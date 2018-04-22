Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48w+sZMegb1rGAeWju8sKo7DiMrueq2CDioDQOXT7LaaJMeRQ0SBYw9nSDoJO7jAzOqQy1M
ARC-Seal: i=1; a=rsa-sha256; t=1524405618; cv=none;
        d=google.com; s=arc-20160816;
        b=WNRSr8BvVST/US9L2zsQPppgYlV8QOwexoIhan8Hn49+ZkqPkM8YtKctvn+CDeNVAs
         DToRiWupd8HXwCwlOK06PUuHOa9iRxeRApWCklJlfWHy+lPWl8FDqsAlVm+fAmL2PKZG
         sSUL9ySFypCMez43CV4esnCFFZQ6SW9P0XNIB+FfE6txWhrQyGVkxeflNsgmg78+RjJ1
         KaeYDacSaWGh0yCdVPWiuA5qGvtGIV5ffGGJCUIlTfRvnbpqxMW2tE++LGybidfq2Sd4
         TOyINbRKNyD7CcKm7wDaLtQARVLXXb0AuHTevblRsTDyNjOC4pQ4kYRb+n/KrTDYdZVz
         cLow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qzVDK7GtqX66QAnJCUtjjVKNCxnyX/LCKoFlqL/GLcc=;
        b=qIHk9j/BRUNVHzYK95NqrCM3X8KFEP1+rUI/OvbnIDDt02dZoEsQqKKKYaMrsw4/Np
         c5Vl8t5xU8nvDbt32miD6khCYLpJdqJsR7o+TVBjJcZ1BAmcM+ya5b6yn6NLnQjqweKQ
         3I5KyZBId849wiPUHCUzIrWet1WX1RkFTiS6E84dF53tvMcrfFEAn/gx+vXQEye33wzc
         zaqqS5BgYlp0V+51dQJfWBxKw+XsVULiTKjH+APCMIrAEa9200oiPocrsV2ONDkHVLOu
         BdQWD6zs4ekU4SOVxZuPD1kBm0PYohI/zUaNDTxPMD6+UZ67hy47ePru1Zz0l0dFW9ev
         tITQ==
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
Subject: [PATCH 4.16 133/196] mmc: tmio: Fix error handling when issuing CMD23
Date: Sun, 22 Apr 2018 15:52:33 +0200
Message-Id: <20180422135111.124030175@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455146148762701?=
X-GMAIL-MSGID: =?utf-8?q?1598455146148762701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
