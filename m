Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49GYpr2pbcoNf2qmyiM/9yvYgp3kaayIgX/JFoccua0peR8YBiPNNQSaB++yaAzn3WdbW/l
ARC-Seal: i=1; a=rsa-sha256; t=1523021562; cv=none;
        d=google.com; s=arc-20160816;
        b=dYVuNqilSy3WOHsZwh+9sUnI0BMAlwKj4WCObyfxSQJbFkVFdlQ6J8PGPRyk9KaMLX
         MZQhrFta8Z8joKVt+ATBjJ1Q7SohEHLQnj6dryZn4z3FSj+owovYisHW7Wt+xR63/5g+
         Bd227wHQYGOx6s33s3J/GgvZ2lPoNF/tiLgoweqkIgE2JGXBVcbHwnud4OzsnBj8MRTx
         0bXUEIOX1uK+awGh4uKMrdC9VO//k0CKhtMY4RucPBU1gxEooFaYemOr2U+0ZHfTYpKq
         poXE0LjWuiS0GrBdttODcLPxSv9pjcov7KZ2Qm+JSS9L35RifASGyBAwGxGr8J79QUl2
         zQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K7u0bSr7Z/sjaE7i/W5P5Nqxr3QuFvpPEF8zD+HUyUM=;
        b=IVmt2Vrun7vAtpkLK7bJ5ZDin9r41+znpbiR12VfegyuJ84xML7/WhITgac7gRAecn
         y32L3ADygT2mMOVTTatDJ4fM5qhtXjpXlYEVp40BSDfgdvWp8bL1tta9SMZJXqBNTlgD
         8MBgjsQvVlKkceMYogl1MAl6uFHpM6d84GjJwyTU5U7VxplDEBHalX1mw5u8KgJVkqNz
         jZtzq1R8bujwpoti0sn24zbIWA+uq2Q4/rjNWi8cqQwEYCNp+PjGBI0hQlXuVPy7RzNX
         z+HgcACwnGYqH46y+umTMZkH9CZgJan2RiogDfWtlukhvDBVnFy3C0QDla1cdLRib7nB
         R9Fg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kohji Okuno <okuno.kohji@jp.panasonic.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.9 001/102] ARM: 8746/1: vfp: Go back to clearing vfp_current_hw_state[]
Date: Fri,  6 Apr 2018 15:22:42 +0200
Message-Id: <20180406084331.656740008@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003857748716449?=
X-GMAIL-MSGID: =?utf-8?q?1597003857748716449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <festevam@gmail.com>

commit 1328f02005bbbaed15b9d5b7f3ab5ec9d4d5268a upstream.

Commit 384b38b66947 ("ARM: 7873/1: vfp: clear vfp_current_hw_state
for dying cpu") fixed the cpu dying notifier by clearing
vfp_current_hw_state[]. However commit e5b61bafe704 ("arm: Convert VFP
hotplug notifiers to state machine") incorrectly used the original
vfp_force_reload() function in the cpu dying notifier.

Fix it by going back to clearing vfp_current_hw_state[].

Fixes: e5b61bafe704 ("arm: Convert VFP hotplug notifiers to state machine")
Cc: linux-stable <stable@vger.kernel.org>
Reported-by: Kohji Okuno <okuno.kohji@jp.panasonic.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/vfp/vfpmodule.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -648,7 +648,7 @@ int vfp_restore_user_hwstate(struct user
  */
 static int vfp_dying_cpu(unsigned int cpu)
 {
-	vfp_force_reload(cpu, current_thread_info());
+	vfp_current_hw_state[cpu] = NULL;
 	return 0;
 }
 
