Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224VuEHWchto7l7qKJEK/wYbzbK4kEL0JYAzfS1t9duhHtiJUTVwfxODCaFK7dcxVmNnUxT5
ARC-Seal: i=1; a=rsa-sha256; t=1519412197; cv=none;
        d=google.com; s=arc-20160816;
        b=uyPS9vdIb0JdWXAfF1lTyQUjoADIm/s79a3m7bw3OoEPri+pPnMcMBlUrAu3uqle+4
         3r/gQ6Fa430aQ4XgISMs6m7TmNAvZ2ZNVR/mB/y+8FL69cCnzEr5j29PkuL7hdQTz3cQ
         hAcR9UqJQkJ+RXMFNOOdfBzHPxi4HvzrOSdn3yp9X16RvvBT1L6ebbqYyikJEkqYJ4mH
         9uocv/GMK2e8n88vj8qkgUSx/2ad9Dr8xixD9pOAjVfzUsAKrwnpS1CZBakDxXbvrP47
         EkPf0xsmkM/+1LDTlzR9lUYn5m92YrskFI9tlysTKUaMDv2Sv9zdV12WpCiqsTH6X+/m
         cgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=y05b7ngYxTauyRKzGcnIYkuwle+xCKWUWUfnbdfkNFQ=;
        b=XxtMuqOqU/Q1l0UgAbSODHYMaBfnnhRV4z2ozkk+58ucImvWKSa2/6OdG/DszCY/CW
         VS3mLzwd/DGWz/mtsTP2aDdHlQaNdJNHkCRzBnLyOuhlCfjRG1x8zTeaGG2hBULrBbm+
         +ngwBYV9KvEC9H6zyd2mM0ktRYesMhWiGDfO0PrP+DK16KnbccI0ToOFQ+FBGhCYr1Ub
         kkGFjSiPKOUffZHfUgqVLZf3itOLuoOyHWc9peE7NlKQqnPykiX96YDxhAm1nlWhqyYC
         Z8ZMxvDtfGqNymwUrhgJn7vhJhevyNcD5ZIIBKqJTGdCcoIuVNgP2v/0Xg1aQFrQM9os
         Xgpg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikolay Borisov <nborisov@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 120/159] btrfs: Fix possible off-by-one in btrfs_search_path_in_tree
Date: Fri, 23 Feb 2018 19:27:08 +0100
Message-Id: <20180223170757.806340242@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217660394969402?=
X-GMAIL-MSGID: =?utf-8?q?1593219164296827699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>


[ Upstream commit c8bcbfbd239ed60a6562964b58034ac8a25f4c31 ]

The name char array passed to btrfs_search_path_in_tree is of size
BTRFS_INO_LOOKUP_PATH_MAX (4080). So the actual accessible char indexes
are in the range of [0, 4079]. Currently the code uses the define but this
represents an off-by-one.

Implications:

Size of btrfs_ioctl_ino_lookup_args is 4096, so the new byte will be
written to extra space, not some padding that could be provided by the
allocator.

btrfs-progs store the arguments on stack, but kernel does own copy of
the ioctl buffer and the off-by-one overwrite does not affect userspace,
but the ending 0 might be lost.

Kernel ioctl buffer is allocated dynamically so we're overwriting
somebody else's memory, and the ioctl is privileged if args.objectid is
not 256. Which is in most cases, but resolving a subvolume stored in
another directory will trigger that path.

Before this patch the buffer was one byte larger, but then the -1 was
not added.

Fixes: ac8e9819d71f907 ("Btrfs: add search and inode lookup ioctls")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ added implications ]
Signed-off-by: David Sterba <dsterba@suse.com>

Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2221,7 +2221,7 @@ static noinline int btrfs_search_path_in
 	if (!path)
 		return -ENOMEM;
 
-	ptr = &name[BTRFS_INO_LOOKUP_PATH_MAX];
+	ptr = &name[BTRFS_INO_LOOKUP_PATH_MAX - 1];
 
 	key.objectid = tree_id;
 	key.type = BTRFS_ROOT_ITEM_KEY;
