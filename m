Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuUTzyHxESBhqixSNbHFvoSzOMe67LegptaT2OqcSXRTH94dIt6lmnTqszJOMA/XOANE6SD
ARC-Seal: i=1; a=rsa-sha256; t=1521214559; cv=none;
        d=google.com; s=arc-20160816;
        b=gyjMK9mxHBdk2QJWHVZEvael4pXgBBV4y7aooj14HgLWDy97lTeHeCxWEYOpZfUUM8
         bhhoZQO/jt8uVlNnCq1DAl8IW8iOMT95dbYgMPEgCqkA26tVAA3HOH8sPIR4jBWE91+5
         XQ6lzw0diaLa5MA3Q3qv8vITH1RZicB1J1q9BOpleOZEKFnXJUW1ZI1qHrMYkZKekX0d
         p1iLpCPxAzkpoL2It3huGwFxr7W93pZiHGOjzVr8TgMeD+ihQmgl0XyB9DGnCRigHzXe
         RNzVglzcfJfVTArYX/VnDjSuOpkY1G4nCw3vLUYxPps6+zFTJL6UJl+/lS6lyudNJaqe
         yIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sPMuuWSXMMeVCfLZ6UO3ZZNOi5IGWpNWC9HAqgR5wXs=;
        b=X1QDFW9MTiz1cEU607gLLNt9cd6qX59GoqVGmBFOTWkDbhAaS2gaEJBpFxi1buH7TO
         WX75takIVr7YubozPa/tUkHSuBonjD48hpSYtOBDXM68oZwH+aYLWIZgMO/iwJYKtbe7
         +aDgXp4ZGg4L1qhdCI71piiscb+CTRFlN0+GElXADf4gpKnwBIUN0RL4jTMQjoWjRLbP
         0O+YKllUSE18fCC8RWUvg4PtKDne5O26qgTBYmUGgxzQ+zL9GyLyhP8ktswUnQDYrUB1
         reFteS60Ev+DGypZ4pYuIynIvNa5n+qMAWj2zXPqWRnpENJkJrgoGNjTE6g74cj//+2y
         av1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sunil Goutham <sgoutham@cavium.com>,
	cjacob <cjacob@caviumnetworks.com>,
	Aleksey Makarov <aleksey.makarov@cavium.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 049/109] net: thunderx: Set max queue count taking XDP_TX into account
Date: Fri, 16 Mar 2018 16:23:18 +0100
Message-Id: <20180316152332.623047900@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109077890982286?=
X-GMAIL-MSGID: =?utf-8?q?1595109077890982286?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sunil Goutham <sgoutham@cavium.com>


[ Upstream commit 87de083857aa269fb171ef0b39696b2888361c58 ]

on T81 there are only 4 cores, hence setting max queue count to 4
would leave nothing for XDP_TX. This patch fixes this by doubling
max queue count in above scenarios.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
Signed-off-by: cjacob <cjacob@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1832,6 +1832,11 @@ static int nicvf_probe(struct pci_dev *p
 	nic->pdev = pdev;
 	nic->pnicvf = nic;
 	nic->max_queues = qcount;
+	/* If no of CPUs are too low, there won't be any queues left
+	 * for XDP_TX, hence double it.
+	 */
+	if (!nic->t88)
+		nic->max_queues *= 2;
 
 	/* MAP VF's configuration registers */
 	nic->reg_base = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
