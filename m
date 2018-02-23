Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227jJSW/ntEvaF3B1pqvGiA6uSAGYJik+N66Sm05+OElCqv/99wHUnpw/OVnE671vWM6RHvo
ARC-Seal: i=1; a=rsa-sha256; t=1519411511; cv=none;
        d=google.com; s=arc-20160816;
        b=VdEfiZY4TjQD1/7QBzZScDIKe2UVrPTINPLKOb2bfPG+UIxYG5bjeHxvXEQ7/ilxWd
         ajn/V7X5lUREJ1BL49SjotAek3Y5PGhtwD5xgudd3ymCE7uVTTOjfG8i5h8nTNTp/KDT
         e6/m/mjkVJ6wyiHZ+2zJ9EZXKv90wdkSDsXF9v1t24wwxLruvWd3PzHBNOiDWqDYpJlF
         /SIZAQecOzvWFujfLIpX7DWfOeSFULZI+lGEkNdvU+UkD19SpViihrgB0UgLVC3AqvXS
         vM6P0oXs4q/seOvlK0wPE+h8zwg61Qcmqjdo6wGNFLPK1f3+zvg/2CboB9YP19NszG74
         wQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EoElfQNSVu7x4DhvXeoTGaAClC6jDl9swcn6j4JgQoQ=;
        b=hH3eY3NXDnjOaOLr3okPO+wSY0FQnU+F+TnxeZWtRW4P9rYrhjsnVxOPjMiifrSiBQ
         Vs7YinD282KDQH+O6mX0BTVqxXUSWU7yoVMI/+DRh+IHtKSIRZE9h1a0Q2Db14EqGpEj
         i0V+q9tMWoJxpJmZ45s3QC0ywhRZTEIUxqJko7ok3h1Qzi/BeBTe//adF2q1boKrKJts
         psZtiiT97sirQXfnn8L+lIgdS/eaDLODoj5x1nhvuYCa+g7JXTArlHRLYEIYVlk29YGg
         6pfy4sbxurTrREYJvOI06/HTVhhM/V5w6GYVwW5km7zK8iX/3Akw3AIG16POwAgChgx+
         3wMA==
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
Subject: [PATCH 4.9 067/145] btrfs: Fix possible off-by-one in btrfs_search_path_in_tree
Date: Fri, 23 Feb 2018 19:26:13 +0100
Message-Id: <20180223170733.329401059@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217660394969402?=
X-GMAIL-MSGID: =?utf-8?q?1593218444758107789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2244,7 +2244,7 @@ static noinline int btrfs_search_path_in
 	if (!path)
 		return -ENOMEM;
 
-	ptr = &name[BTRFS_INO_LOOKUP_PATH_MAX];
+	ptr = &name[BTRFS_INO_LOOKUP_PATH_MAX - 1];
 
 	key.objectid = tree_id;
 	key.type = BTRFS_ROOT_ITEM_KEY;
