Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvDrENeKaIWh14aVemCsih3xheCxqXdsuKjFGiOSRf5RLFtZNnNgt4SMkmmM/Eab87zF/T6
ARC-Seal: i=1; a=rsa-sha256; t=1519410886; cv=none;
        d=google.com; s=arc-20160816;
        b=SBk/zSgoBbjaroc01t+xxCmRkrGXGbAFNW5wStHHgdQ+shKGGi9+Bm4VKz0STSN7D7
         PKF1q7uA0+B6uDnbz1tghbE8xt1tJwL7dEFW8fMOK4oD3mnnkqufrlP9Y0MJsB9r6dMl
         NWlfRKkPJ03HTjPrHe97TPf7qDRS8YOzH2e5+8AZDDm8konMSYM0/CUVHbKI/N7bnt7D
         gC7i5Odyag0CduJWrmf7MjboYsysPgO2HOh2Jy82Z6XXVfVhwd/1Jx7Qx/kAS5XSwKor
         4iSOCPFa1teqO9YSXqQDcLz4bGxHNPgZuY6nnfHnXC8b69ALhuc+hBxQR9jOnrftye8r
         E/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zyEpc2kXttN0xTeBvqBVu0ZPBtF2K6J3rpv1Zhvtt5k=;
        b=c6HTqrFVIKrIEFFlmn+avBSV9oK6wptqkUd7NTm6Q02miOsqZ3QBxVrXPvZLBDFcpB
         0b/j7QaB3+YQMx9JuaXuXHt329VasDUc85RjEs1cZ7jH10HCjocBPPaDQUNbXhf2aale
         7Fpx+Vej3WIHD9TBbAAaW2ZUOq87oCUTNywuFsAlfx2oM4BK/JdPD9dGXLVWIeoMA2/f
         aP7+DV+JJjTttVsq/O655e3KknL4al8h+vOJI00OAipi98EIUzvXhF9s+jk7xg4CpZVw
         py4KQgiTGgeVkdLUj6ghVfXAHvAGSJ2VerrcKHNTlze9shq3YvC3SQ8phNlvzLBIrlzt
         J4GA==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 048/193] btrfs: Fix possible off-by-one in btrfs_search_path_in_tree
Date: Fri, 23 Feb 2018 19:24:41 +0100
Message-Id: <20180223170333.493308033@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217660394969402?=
X-GMAIL-MSGID: =?utf-8?q?1593217789524213551?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2231,7 +2231,7 @@ static noinline int btrfs_search_path_in
 	if (!path)
 		return -ENOMEM;
 
-	ptr = &name[BTRFS_INO_LOOKUP_PATH_MAX];
+	ptr = &name[BTRFS_INO_LOOKUP_PATH_MAX - 1];
 
 	key.objectid = tree_id;
 	key.type = BTRFS_ROOT_ITEM_KEY;
