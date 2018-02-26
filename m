Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227s0rnpK098fGcW0hlTbCynLKQpOY08cwvC4uyccUf1M0ZHSLYUlUnJq/2dOKjISop6ousS
ARC-Seal: i=1; a=rsa-sha256; t=1519676687; cv=none;
        d=google.com; s=arc-20160816;
        b=DjDTKpbsPEUVAymYSTGqbjiGzpgmbj2vxN3Wly48loQrVVE+T2jUGzO09AZHm7H5rl
         X8Eu985ssQMRipLjr5mLiJeu/VF73cjY+OmK9AEjCZuYOb/nQ+rckqZD+CA2IZO0zX4F
         qVdGxsp5tp2VP8Y64NJQQ3xoc63sl6cr6xXKPDt/vpBTpkDDLqOUwUS9ivG1tAKf5b7T
         JDIvp/lbr/LXFdC7M5Q9xkBmQVpCzqR50AGxAddM413feQdTZ/s97J6iLKT5muV6E2MX
         ku0nH27r6cmifHmaQ5SGG43oRAm9iWykFPsR8/uqX0Ol6lZU8UuPETfP66Q7wvPTGjcf
         v/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HwBiXabckjXCInN8m5rq8eB8Fs5+38v+L+8wCc37mX8=;
        b=RrF3PEIE66C/wtFoJIG2QIwFMJ8/0hKJo5evdN1bBqpAr1O6wgYnYN+iSOD6L4pdXT
         NBzagQMSsxsmHAzkGh1IklLmnIkIopTPeq1zv3/LE16WfTtkPyER9JzFue2I6BNOG4nj
         sfAGT7h6uBMAT+6H7bjTkzOUOyEQPBzWh2S19ru78IiS1K03iqrXZrIviCMrZFfMdiUI
         oMfF5pyaeb6zX4YtkcTLbANdZOSykZ+42PY4wlcit5Qm7BBGFEJVhgKFiZUl7rPNX7XT
         7p18epBLfvaN6ZHvlA99GWWiJ038IaRjuUPZJTUNa7VyCApepZOQu9gWv+yFsCgaN/ea
         gkag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Mamonov <pmamonov@gmail.com>,
	James Hogan <jhogan@kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-mips@linux-mips.org
Subject: [PATCH 4.14 07/54] MIPS: Drop spurious __unused in struct compat_flock
Date: Mon, 26 Feb 2018 21:21:44 +0100
Message-Id: <20180226202144.720516819@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496502135975414?=
X-GMAIL-MSGID: =?utf-8?q?1593496502135975414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit 6ae1756faddefd7494353380ee546dd38c2f97eb upstream.

MIPS' struct compat_flock doesn't match the 32-bit struct flock, as it
has an extra short __unused before pad[4], which combined with alignment
increases the size to 40 bytes compared with struct flock's 36 bytes.

Since commit 8c6657cb50cb ("Switch flock copyin/copyout primitives to
copy_{from,to}_user()"), put_compat_flock() writes the full compat_flock
struct to userland, which results in corruption of the userland word
after the struct flock when running 32-bit userlands on 64-bit kernels.

This was observed to cause a bus error exception when starting Firefox
on Debian 8 (Jessie).

Reported-by: Peter Mamonov <pmamonov@gmail.com>
Signed-off-by: James Hogan <jhogan@kernel.org>
Tested-by: Peter Mamonov <pmamonov@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.13+
Patchwork: https://patchwork.linux-mips.org/patch/18646/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/compat.h |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -86,7 +86,6 @@ struct compat_flock {
 	compat_off_t	l_len;
 	s32		l_sysid;
 	compat_pid_t	l_pid;
-	short		__unused;
 	s32		pad[4];
 };
 
