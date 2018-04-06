Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/kyBbjKViFfamrtt9Ft9V1tHLYszlnm4s6xLZ8jeZl5SgsY0sz3eqKRWeUDNwID5vh2EVc
ARC-Seal: i=1; a=rsa-sha256; t=1523022061; cv=none;
        d=google.com; s=arc-20160816;
        b=Jv+VL2jPqmIs5w6SvrcF+Qbo8uzr50cU3oj747ExvUMuFwaz9v3SBKnXUFVF4yzr/Z
         Zqti5RRYbCl6ko6/YUtr+UAFFHNaDYb7lYKmhhGZuvMNF7T2iHmpmw5ezNwuvRKFHT/F
         AOwXGnnxKYSY/dVRPho8pMU2APIKhPSxYt+0WWbf7xaRytHIdWlhk0upcSD8yNBDdX1A
         rw9/SNO/X8bS3vJ/sHDSpg8srp6xT1FNExdJhjuaRe/OfFdEykgviDkN1n92/nqyTx21
         7aPPlkJ0Hdrtj5r0ra75p5OvaNvZJSHaFOadJhWYTRluvIv7lRpwdLwzvOkt6ZeSNRFg
         A3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7A3PSD7KLaf4sagn266ZmICS2LqVRtGjgxi2iWymNgY=;
        b=b9l2FgJBNPkOMB172QlvUGiNiRxGwxqf2No12Tt0ltLU2leFBbcU88D6GsYuRKTj8C
         z/8wreQvxKtROdkXzus5d4oWcvLROtmnd2VCgguHP5qSlESp0DrKgeT/tiw4VrqrkGYt
         P/yJozY9F+rLELCV5KzpusC6EcOY2jrKp4tP05bW3jC5nT/WWBb+CV/am2u4fy3DcPcR
         OIqbjKNtei2gwjirL4/BdJt//CdDQqc7ZGMlRR3rV2ZvBMMG8HgphII65v5BD4SXAWDs
         izMaEgaJ2oHWNrIhkBkcZ1+iG8wVQHKb6wFMrZr4P1jV2aZ8012qP0nEOrgdRMLeV8rZ
         8qhQ==
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
Subject: [PATCH 4.15 02/72] ARM: 8746/1: vfp: Go back to clearing vfp_current_hw_state[]
Date: Fri,  6 Apr 2018 15:23:37 +0200
Message-Id: <20180406084349.639625285@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003857748716449?=
X-GMAIL-MSGID: =?utf-8?q?1597004380806101171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
