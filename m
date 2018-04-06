Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+1QGf+bbQfvfCZUsfMztylaOJzNP9k6Lz/FZvy9/C1NyMQJyCNzOEpxCacoEVwhf+1CVQY
ARC-Seal: i=1; a=rsa-sha256; t=1523021876; cv=none;
        d=google.com; s=arc-20160816;
        b=tXPximvV7BMWPkGsdvc3vRuhlJioy18CcqkD4i6SfvQ9WWbVwMEw4Md9/iXmRLbnGg
         jue56jFlYnBsnCHMxeSHDDoN5fK7en/X6oeHuGathQnlpuIQ267NQCLl2V3PFy7KX8/J
         ojzY7WSCyWy27gmC9zdV77xhkE/dUFTIJKRh7OXqq+GipRLIK8hcwSpEonmr58rrjE2l
         gjrQ26RXaX1xRpH2ifpTd2U6va3ctD81e22LS8S/YDk+53dPSjXTIbJ5mYmfN6Lwu5W/
         8AIwztOET5EmTQFERKczRAL21zrtuwm1U8SR1F+s9rdubO4V9wap/LzUbIGe8GgpPllb
         2LyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=f7KqyBN8vmwGPqkS7qVBYEF4JshbKCcrqtxaMe/rsS8=;
        b=z13Y3Wsjai6dC4RIzld9x/F8r65Hl6Ypj4UmD+qHies3ydctJtDluRz62EmPIs0wUG
         DUXUWPJiwI9ArJwCdgZYSgvnOgoKXQu11PIl76jWKX6+XjisQxDUr8xdKPed6oF5NT0d
         mf/WaMDsYWWQsf/MhRk8kOEel3aIlSEGT6TC++roNLznODqfc93T2uo6/LgXNX4k+eV3
         /A+VLZxMZud4UdKo/o8IWGr7hnSLbJXsTzcjZGhMwzq7QPTn52TyNWSc44/0lgBudbIr
         9RXN5TeaECsAB48LVN10c7Ze3BP/ah25ND/0qcH1+SdqjZrNc9xKWhAagi39bSZn6DyW
         7hTw==
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
Subject: [PATCH 4.14 02/67] ARM: 8746/1: vfp: Go back to clearing vfp_current_hw_state[]
Date: Fri,  6 Apr 2018 15:23:32 +0200
Message-Id: <20180406084341.575377214@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003857748716449?=
X-GMAIL-MSGID: =?utf-8?q?1597004187060511205?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
