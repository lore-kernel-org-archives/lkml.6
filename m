Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx481pOIFjw8r7gltMs+tqaWkp7nBJzf2dwH27D+X09UBwPOgSC5SgiNocmwW3wXcBlCRfYhx
ARC-Seal: i=1; a=rsa-sha256; t=1524652904; cv=none;
        d=google.com; s=arc-20160816;
        b=aF0Ft9cBgB+ATXhOW7hCLoIEC0SP2IhJvx3fgxxEW0YSmZmLx9KqSK3DVgtGITzJ/v
         +vba4kCuOP1HAbx3vgbmST+sIHO0P5QnhJ4obpc+Lw7ZQEgyGTpGIJd3FGY8rf9+pDQS
         eM6fBupbaOaxowCiYTURbkMCq62Xfh7/C/XrXPkgw313UITi3XPI3XdWn6Yth1sUrEBr
         HumpeyzS4L6obk8vvGsGvf8Fu9ap+W56djWCTcE94BcMhtNpbY2or5uiZV79NvViYH1T
         /L45a17bsZuu7qOfqbPbg9I/5WuSj1ulb21sD1DNrP8Rt4ZCSek6mfj9MZKLCYjh08f3
         ogZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xt6iHrR/0nzpNgxsgZpKENP9aQlkVz+NcmI+2nnL5iY=;
        b=xDVdU62fIQz8JDlv/3+GpJ0VM3+KIq7g1R9HHnkYdCC79v9C+B4J9tECVbI+6GVslP
         cfPlvAU7dU58ComoY6m5+3zTRBpzowrFHYWy5AyPf4C3YLxot6DHhxi8gfq4EwIFQpys
         Q3wEGVu9odgRIDha0JFP5MnSD5NjVpZ3M8O+dC0SKCOXor1wsetBKCvW7LcOHgjQX41L
         7OkWMwDqCUDzshZF7yJHBOJVCkmmUKcdrDHvpP8KjrS5LwtKSSyDfaCNHnqqVG/pT+ao
         w38u/OcJ1JZy4nL8MSCphBrQ/Wt0btiuVvjyR8ntKURi64VfQLX7fGuiCeY7cVHTDUhW
         pp6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Anand Jain <anand.jain@oracle.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 066/183] btrfs: fail mount when sb flag is not in BTRFS_SUPER_FLAG_SUPP
Date: Wed, 25 Apr 2018 12:34:46 +0200
Message-Id: <20180425103245.176575157@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714444098534177?=
X-GMAIL-MSGID: =?utf-8?q?1598714444098534177?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <Anand.Jain@oracle.com>


[ Upstream commit 6f794e3c5c8f8fdd3b5bb20d9ded894e685b5bbe ]

It appears from the original commit [1] that there isn't any design
specific reason not to fail the mount instead of just warning. This
patch will change it to fail.

[1]
 commit 319e4d0661e5323c9f9945f0f8fb5905e5fe74c3
    btrfs: Enhance super validation check

Fixes: 319e4d0661e5323 ("btrfs: Enhance super validation check")
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4063,9 +4063,11 @@ static int btrfs_check_super_valid(struc
 		btrfs_err(fs_info, "no valid FS found");
 		ret = -EINVAL;
 	}
-	if (btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP)
-		btrfs_warn(fs_info, "unrecognized super flag: %llu",
+	if (btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP) {
+		btrfs_err(fs_info, "unrecognized or unsupported super flag: %llu",
 				btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP);
+		ret = -EINVAL;
+	}
 	if (btrfs_super_root_level(sb) >= BTRFS_MAX_LEVEL) {
 		btrfs_err(fs_info, "tree_root level too big: %d >= %d",
 				btrfs_super_root_level(sb), BTRFS_MAX_LEVEL);
