Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/bs+fr3/k5UxNlE+IeHzcZVtZjLGb7hPFdskcqC5RiCMtlGAPeIEFmcgFunmgxrB5nRQER
ARC-Seal: i=1; a=rsa-sha256; t=1524406080; cv=none;
        d=google.com; s=arc-20160816;
        b=iPepJR2jULAgU7osKI27phuvF/g40rUbqVGzYLWRN3ICD7bUrzHOWAcFkBMN/2X6dr
         QorWTJRB993ObTnzcojZabgoM/ZVYPGPhoyoZd6xqQRodQStsWj2VgpwB0fNxenIPIai
         BVptoVljfmS0Kqjcbe9C2qXw+qDMhAvVgXniI9stjAph2kiTw14Wo+UgGgkctoODPSl0
         Vo0Fhua4iES3RdlmJVMjp97tHQAnWu10BNiRNZQ4W/1vtFgfag/OBr+dEjusTvJTLpUq
         ulEKIVEs1G53UNg0voEfnUYTts2M/On0nwjWdMEjop/6Muykq9CSF2Mnw81Q7TOXAhEs
         oMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Z7QyM9ANCpdkCThTzNiTK5JmEiYNwqatKyPcOnDLGiU=;
        b=JkRVayUd9JazO2qxKnwZB07dwom2hleO19z99xrqYnIu/n1cJnpFGAJwd9N70hIdM4
         F2KhS2EN8QD1b9Hlz1Ns2qD6ie4S4aFnKLk7XGaY2qRVPkS/LgSJckg4IdZCP/aWyxgH
         xiyW3BYqexkMVd8Yw0IPMo3Wkr8Kh6JkV6V/F77f7AvWAyR996FiwTMBPNxvdxsiCOAR
         Rn51/kjvAnYia6fV534QNwo6qSkyDFLpsNMV5fOdsSSZZZY7aRUmVCXeKkXe+MIG2Yo2
         7bnoQaTOgG5rIEAmJdRpIcXXQ5mpEWSBzzJq0RYoP/foC0gJftBGdUmKeBdxEhh9UrMt
         Rsjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 104/164] mmc: tmio: Fix error handling when issuing CMD23
Date: Sun, 22 Apr 2018 15:52:51 +0200
Message-Id: <20180422135139.663647015@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455146148762701?=
X-GMAIL-MSGID: =?utf-8?q?1598455630127690337?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

commit fc167daff581c01ebce8695e9618231cae3561a1 upstream.

If an error was detected when CMD23 was issued, command sequence should
be terminated with errors and CMD23 should be issued after retuning.

Fixes: 8b22c3c18be5 ("mmc: tmio: add CMD23 support")
Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: <stable@vger.kernel.org> # 4.13+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/tmio_mmc_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -911,7 +911,7 @@ static void tmio_mmc_finish_request(stru
 		host->check_scc_error(host);
 
 	/* If SET_BLOCK_COUNT, continue with main command */
-	if (host->mrq) {
+	if (host->mrq && !mrq->cmd->error) {
 		tmio_process_mrq(host, mrq);
 		return;
 	}
