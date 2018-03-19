Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELspYRzfXZuEstyEOeoYKDKnwy9oHc/kDoAIxrhZIkTnLvP3z9y4uIyEUhUMjrOaxAHKBNEN
ARC-Seal: i=1; a=rsa-sha256; t=1521484071; cv=none;
        d=google.com; s=arc-20160816;
        b=OvLuJYakzXlKDuo9/Zdan+3weOUimg3YTnWM5F2FpSP9AkfkcHUsu9xl5YeeEiQbQJ
         H06EaH0eZ58PUxVW47qVFj2APst4RtJkDE85oU4EaJZ3sqZfZc04DkDnKkB7spP3ZEha
         wPxdg97XFJVk3+2tegVO1vIVWTPh+zSy4BrkjMbDrZ2r9AqVjrg9hFaERZed4BxSzX9t
         zHEtr6Y4QQt+bhM0qz++eC3HOaCgC+YSuLdo+LSDBrumZXRhf2whNuj8PpkDvJfZK8Fv
         Tykbmsst9RM4Fjle8/d80YO3SwAR/9T2P4Q8QMktjK1sqhzFK2jC71rKV+Vb5Ygcr+EV
         W9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c0NHVWcXy2G7eZUD1WDhDcN6x2fx6qgLe2Dy5bPQkog=;
        b=fF2d1gN3FC5zCm7Vf5s6lx4tGZ7aw0HJaVon+AuffqZh40WkJOOzf/i1RpyL/AK/wG
         rDeEbe3Gft2bzQ6SMKjKKPLffJPpWPA1li9X3N+AlNopBgilXRR/GAOMPVTDoy5O9Gqg
         2UeTaFRekD2Clx7pUvoYsVAX4yIWraZLYCEZxUu9Vy/ZseincrDxagR1Bq08ApOrFwc5
         YWjgQzZ8IBdyt/+If19kHT7oS493Yx3cxUUcmrA+7sdw/u9BTEbGbwco9QRPMbYQbEnD
         pmSKorM0NLEIVn8AjmyyFWbOt+jvbF4eemewE+TpugpH/KPMiyYcpI2cvQjF9J1Zujpn
         D40w==
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
Subject: [PATCH 4.9 176/241] net: thunderx: Set max queue count taking XDP_TX into account
Date: Mon, 19 Mar 2018 19:07:21 +0100
Message-Id: <20180319180758.436839994@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391681862439745?=
X-GMAIL-MSGID: =?utf-8?q?1595391681862439745?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1576,6 +1576,11 @@ static int nicvf_probe(struct pci_dev *p
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
