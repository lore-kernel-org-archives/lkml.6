Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZoQ1G92HADykOccdGuircZBcVLQamlnyVsF8seYjYVSGCusnei0mB1qioL/wVlKzSavucZg
ARC-Seal: i=1; a=rsa-sha256; t=1524652851; cv=none;
        d=google.com; s=arc-20160816;
        b=pqYX4AqjZJ9iNCAYj5FdNukjxZ+ZwnTIzz+xsprnr/LDCRe1fq4t14Skzikdxu/YqL
         iz1mL2yJmugL7mkYC8j1uvzs/S+VpgUcq/yfTxDktvJhTDMpFw7RArTLFhLAIhRLJ+TH
         3p9gJBZfdYQzaJHNSdrxjh/iQTtLPis2UzDm9N9dAzqYsM3GOoSGZYO6QlMsMIioO7ZC
         Q8xXG0skWx+FGLE//CEundFzR09/XlQwh4IwRgb5c+Dzhzn5NA3wdL3IaINXvOuxNnvI
         u9mYNzhPnW2YcTGbDd6hzqWvD25aO8hYFGS089WOuMidbT10l8FfzkQKt4IpcTOvJkm2
         ERcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fWvOU977ttCKycOtIuCuGwhIEztLeF9lE0ey+5usXcs=;
        b=OI41gsmDof41033NLRzM3hCsCEsvecHi5yrARnZtONL1+kqKsumDby19BCJVv9CMQW
         UZ/oCwKgYzIff+z2QaOtz8hr7nUIJyV6isOQ+1XBw+3alv/yBHrzJPa6AXFcJ/fxZZ7D
         hIqddvlnKqLgChd5Y3R86PFdPrg13h/sYd4QAzf6tILPTTCFgsCGhm4uLdgWqpKGy21E
         NmdK8w2xIZgSthAnpKstPil8fURXUEKA48Zy3mtC7LVL0Y0TeY9qFiwwXpp8w56rapcN
         tW2AfprnHYBUiC/wcTcho7Ksgrbwf4ee75ZS5BLqPk4Jb/Dg9N2EwIroK4EfssZhvE4f
         BRmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Jake Daryll Obina <jake.obina@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 092/183] jffs2: Fix use-after-free bug in jffs2_iget()s error handling path
Date: Wed, 25 Apr 2018 12:35:12 +0200
Message-Id: <20180425103246.179225015@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714388633534495?=
X-GMAIL-MSGID: =?utf-8?q?1598714388633534495?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jake Daryll Obina <jake.obina@gmail.com>


[ Upstream commit 5bdd0c6f89fba430e18d636493398389dadc3b17 ]

If jffs2_iget() fails for a newly-allocated inode, jffs2_do_clear_inode()
can get called twice in the error handling path, the first call in
jffs2_iget() itself and the second through iget_failed(). This can result
to a use-after-free error in the second jffs2_do_clear_inode() call, such
as shown by the oops below wherein the second jffs2_do_clear_inode() call
was trying to free node fragments that were already freed in the first
jffs2_do_clear_inode() call.

[   78.178860] jffs2: error: (1904) jffs2_do_read_inode_internal: CRC failed for read_inode of inode 24 at physical location 0x1fc00c
[   78.178914] Unable to handle kernel paging request at virtual address 6b6b6b6b6b6b6b7b
[   78.185871] pgd = ffffffc03a567000
[   78.188794] [6b6b6b6b6b6b6b7b] *pgd=0000000000000000, *pud=0000000000000000
[   78.194968] Internal error: Oops: 96000004 [#1] PREEMPT SMP
...
[   78.513147] PC is at rb_first_postorder+0xc/0x28
[   78.516503] LR is at jffs2_kill_fragtree+0x28/0x90 [jffs2]
[   78.520672] pc : [<ffffff8008323d28>] lr : [<ffffff8000eb1cc8>] pstate: 60000105
[   78.526757] sp : ffffff800cea38f0
[   78.528753] x29: ffffff800cea38f0 x28: ffffffc01f3f8e80
[   78.532754] x27: 0000000000000000 x26: ffffff800cea3c70
[   78.536756] x25: 00000000dc67c8ae x24: ffffffc033d6945d
[   78.540759] x23: ffffffc036811740 x22: ffffff800891a5b8
[   78.544760] x21: 0000000000000000 x20: 0000000000000000
[   78.548762] x19: ffffffc037d48910 x18: ffffff800891a588
[   78.552764] x17: 0000000000000800 x16: 0000000000000c00
[   78.556766] x15: 0000000000000010 x14: 6f2065646f6e695f
[   78.560767] x13: 6461657220726f66 x12: 2064656c69616620
[   78.564769] x11: 435243203a6c616e x10: 7265746e695f6564
[   78.568771] x9 : 6f6e695f64616572 x8 : ffffffc037974038
[   78.572774] x7 : bbbbbbbbbbbbbbbb x6 : 0000000000000008
[   78.576775] x5 : 002f91d85bd44a2f x4 : 0000000000000000
[   78.580777] x3 : 0000000000000000 x2 : 000000403755e000
[   78.584779] x1 : 6b6b6b6b6b6b6b6b x0 : 6b6b6b6b6b6b6b6b
...
[   79.038551] [<ffffff8008323d28>] rb_first_postorder+0xc/0x28
[   79.042962] [<ffffff8000eb5578>] jffs2_do_clear_inode+0x88/0x100 [jffs2]
[   79.048395] [<ffffff8000eb9ddc>] jffs2_evict_inode+0x3c/0x48 [jffs2]
[   79.053443] [<ffffff8008201ca8>] evict+0xb0/0x168
[   79.056835] [<ffffff8008202650>] iput+0x1c0/0x200
[   79.060228] [<ffffff800820408c>] iget_failed+0x30/0x3c
[   79.064097] [<ffffff8000eba0c0>] jffs2_iget+0x2d8/0x360 [jffs2]
[   79.068740] [<ffffff8000eb0a60>] jffs2_lookup+0xe8/0x130 [jffs2]
[   79.073434] [<ffffff80081f1a28>] lookup_slow+0x118/0x190
[   79.077435] [<ffffff80081f4708>] walk_component+0xfc/0x28c
[   79.081610] [<ffffff80081f4dd0>] path_lookupat+0x84/0x108
[   79.085699] [<ffffff80081f5578>] filename_lookup+0x88/0x100
[   79.089960] [<ffffff80081f572c>] user_path_at_empty+0x58/0x6c
[   79.094396] [<ffffff80081ebe14>] vfs_statx+0xa4/0x114
[   79.098138] [<ffffff80081ec44c>] SyS_newfstatat+0x58/0x98
[   79.102227] [<ffffff800808354c>] __sys_trace_return+0x0/0x4
[   79.106489] Code: d65f03c0 f9400001 b40000e1 aa0103e0 (f9400821)

The jffs2_do_clear_inode() call in jffs2_iget() is unnecessary since
iget_failed() will eventually call jffs2_do_clear_inode() if needed, so
just remove it.

Fixes: 5451f79f5f81 ("iget: stop JFFS2 from using iget() and read_inode()")
Reviewed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Jake Daryll Obina <jake.obina@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jffs2/fs.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -362,7 +362,6 @@ error_io:
 	ret = -EIO;
 error:
 	mutex_unlock(&f->sem);
-	jffs2_do_clear_inode(c, f);
 	iget_failed(inode);
 	return ERR_PTR(ret);
 }
