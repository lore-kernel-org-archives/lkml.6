Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48jt+sOj+vLSxkCkw9aH2ECGzNFs6fpqKAXSlWre25VlM2s31+xCnIlTmqfkJBJaqel6XKT
ARC-Seal: i=1; a=rsa-sha256; t=1523981130; cv=none;
        d=google.com; s=arc-20160816;
        b=Tev2c/3bYZAUwqq2LBEe3Vv/+GRXHO+NFtGVTx+FlWygei+Il+pCjpv5eVhcL5A4hp
         Mp3b6AHBzkCR30VO4pXRPM0sc4CeUXWeIQsr4kOSaSFV25gtMDoyoEwX037xmGCxGnHx
         0yyNs7wvbXclpLca0b8fn+X57Gr8cxcQb98UjMWZUtxtsTfDNQjb4EHKZ+N8s0ncWULo
         SmWHOL+fAPRpfo2m3pJpAnaaeAcAZ8znpcO+gADmnv/Kvjibyq+KpQ89Hw08NbTit0fy
         hg7DDTJfne9nMMzCsOtU/w+aayyhvGMI75wYhVw8qHDJKfCx3GIo5znhGajif3WXCYgj
         uGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ycXCsW9xzF2Hjs/MtZyPKqrk/Vdq8olOuynLVk6kc5E=;
        b=op0P1R1I7oC2xoHPMkSpEbcnw7eQ3wNAV0cVRNIFki3TH/MDtztRsXqVLoooY4SMHS
         ojXJ+lDQAf5d+HPvigSNayczz1yp68wMSXMF4+5P9uv/nCzupCsQ0AQTlI6j34fU1ovM
         TUHP6gxrjU1rFtCI1FjKRZSykQN5WFh83UMuGqS/gunbKvuzfqcPoawOWMIl9IOUyJc+
         jWTpcprVdLhw8U5bUKZuoyrv6dQbgUedcm2ngCXD1tmjnN0HiDWDi+QrMqF3FcLzv4Qd
         +zDi8PQMlG/pkFqAbAOYJnDf0e6L8/CoQZOtDdkQdWWgOoU8zZiVDoeRubdk4xjCCklf
         Cr8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.15 46/53] s390/compat: fix setup_frame32
Date: Tue, 17 Apr 2018 17:59:11 +0200
Message-Id: <20180417155725.327864912@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009851419242225?=
X-GMAIL-MSGID: =?utf-8?q?1598010037963553957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit 8b09ca746a643ca452cd41a522046a96ee5a55fd upstream.

Git commit c60a03fee0e5 ("s390: switch to {get,put}_compat_sigset()")
contains a typo and now copies the wrong pointer to user space.
Use the correct pointer instead.

Reported-and-tested-by: Stefan Liebler <stli@linux.vnet.ibm.com>
Fixes: c60a03fee0e5 ("s390: switch to {get,put}_compat_sigset()")
Cc: <stable@vger.kernel.org> # v4.15+
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/compat_signal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/kernel/compat_signal.c
+++ b/arch/s390/kernel/compat_signal.c
@@ -379,7 +379,7 @@ static int setup_frame32(struct ksignal
 	if (put_compat_sigset((compat_sigset_t __user *)frame->sc.oldmask,
 			      set, sizeof(compat_sigset_t)))
 		return -EFAULT;
-	if (__put_user(ptr_to_compat(&frame->sc), &frame->sc.sregs))
+	if (__put_user(ptr_to_compat(&frame->sregs), &frame->sc.sregs))
 		return -EFAULT;
 
 	/* Store registers needed to create the signal frame */
