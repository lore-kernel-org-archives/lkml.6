Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227oPtMrOVJYpvmvlKz4oFcgZ2s97ICa4wP0AJkNWAwI0xPwpz4lIArk6Pv8kaMyoRN3Uwx2
ARC-Seal: i=1; a=rsa-sha256; t=1518709102; cv=none;
        d=google.com; s=arc-20160816;
        b=J39k27trTHAuoTCYfsiHar4BuIWSbWXE/ZwhIFkUsjJAhOGRRlU44ah2YVpfA4FsOJ
         IO+XcSRko5BUdXJC3Um4HOGNREyW5827p1znydMMAisRAhyRtm4lqfH52PWt13hHOOMS
         /zeq4qNg+/DD7y47jB0mFfhfyiBoDgMFNFnB62m63ij0TOFZxlgG76SA93lq5BhITiSY
         UvX/gT3JPcUOX1lCwQIfgMrvcgDVNA5UAL66MvAIP3QHbXNJxNM3yDtvU1ZB3eK8NIkd
         qDcRHvFXdsSNRyyEOx58ZnJ9GHoOiQOhH7wE8mKHqmunoPTsgSW/2bIzdpU/q+XLM+Hf
         ytxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UNhkV7zyaSgj8betJpA1whXeFsLpthwMf0Oi+NgxxRQ=;
        b=i4Pky4nV+L1X4zrrSJIqsyM2pbC9CTLODoCypXiLqQcR+hpV5EO3SFroRq86FFEBSp
         rH0o3oe+qWFyJpeHvIaGTjcWuV6jgO4cqGxox2lEaDkSEhe8hHA0z97C5RedKfFv6kHz
         a1xbzOMZfmBBwUa1dJSQ39cdEjpJXzfHYcH+s0ZsRTmsHhy/glnB8tsoughwsuyRVQNZ
         VFQPCJglkzsAW7PnvRLxpJyrzU+hwqOmMrN4ldMMNAWHNnXPA6/JSy/sbaG2RjAbuQwG
         St/oiPvQ079dJW17dY/VVkB3BWFxZH8GwgEFElsZfpQy2IN27fFLRfUYiplnDJDEfMNH
         CRzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Eric Biggers <ebiggers@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 191/195] devpts: fix error handling in devpts_mntget()
Date: Thu, 15 Feb 2018 16:18:02 +0100
Message-Id: <20180215151715.878189408@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481915554763095?=
X-GMAIL-MSGID: =?utf-8?q?1592481915554763095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit c9cc8d01fb04117928830449388512a5047569c9 upstream.

If devpts_ptmx_path() returns an error code, then devpts_mntget()
dereferences an ERR_PTR():

    BUG: unable to handle kernel paging request at fffffffffffffff5
    IP: devpts_mntget+0x13f/0x280 fs/devpts/inode.c:173

Fix it by returning early in the error paths.

Reproducer:

    #define _GNU_SOURCE
    #include <fcntl.h>
    #include <sched.h>
    #include <sys/ioctl.h>
    #define TIOCGPTPEER _IO('T', 0x41)

    int main()
    {
        for (;;) {
            int fd = open("/dev/ptmx", 0);
            unshare(CLONE_NEWNS);
            ioctl(fd, TIOCGPTPEER, 0);
        }
    }

Fixes: 311fc65c9fb9 ("pty: Repair TIOCGPTPEER")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/devpts/inode.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -168,11 +168,11 @@ struct vfsmount *devpts_mntget(struct fi
 	dput(path.dentry);
 	if (err) {
 		mntput(path.mnt);
-		path.mnt = ERR_PTR(err);
+		return ERR_PTR(err);
 	}
 	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
 		mntput(path.mnt);
-		path.mnt = ERR_PTR(-ENODEV);
+		return ERR_PTR(-ENODEV);
 	}
 	return path.mnt;
 }
