Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/lDYYV6kdT8HWIt0mHsCvdU/r/LqfeqnzReYqrI0jvwzAZMacjei7fT3bkSn3lTYwuRXyf
ARC-Seal: i=1; a=rsa-sha256; t=1523399869; cv=none;
        d=google.com; s=arc-20160816;
        b=Eal3biu7/146KygCo/a4OESOnKbN+NWgSYDmU4Ge5mKPDvDY4ED+iUOPuh/oCEZhiT
         ZdiJ4TFWtrwK4bzDTyZCsaYZvizqFm2EN0C4cGJW02lkZ8v6DBdPgBlCEkrGsAY1lRPq
         vPMmJS5Q2QiX5xkh/NT9mETuNvY4gBPI8xp4L4AVo2TdnHsV7asBNJ5eLz2nR9NaRIuU
         bRKeLPgQc5tN3lpPHXW9dx4sVcx01FV7bBGcRLl2oV8H9IQaoCNjQG5NC9d1FmQfvOEG
         0uHeSxDhDv02l7I/bdYg45pLxPdO69j8S+5ifqLwvMjqby8beGxTv6pZGTx7GOK+dbk/
         3w8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VKj6Q7wIIcsr8L/LAhhsxJo4xhzHK7fQYD1AUPBTeUc=;
        b=SrQCHG8Nodf6RN3zlEfcd2D7zPKNSdAPHtoTZbU8J7xHJAxwOAkwc5rWP5pGmGGdkk
         WjWRKw5f9jDv2nw/bSAo+QqBN+0Hjeg3PFkWRv9VkaI+PgfO6Xln5AVnjc7L6zdffb6W
         NrtSc9Vm+cJxKuzeAkxdPeXaG33Sc+kcWJlvsQHNX4oHdz9s/DXL3pboznIux5Tk38KV
         qd/km33oOJfE01fKSV5+pMH1AeYx7hqQB759AShvQesYUjV+L9T9K9r2ToxH4O5ry0Hv
         8Gu9nfmXPwDCod8B2Fqn5HMlXYK5nYGyU25hMR/Pdf5uDqsvWkSwW1IH8fCR+MlqCxbp
         pJ/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 076/138] ibmvnic: Dont handle RX interrupts when not up.
Date: Wed, 11 Apr 2018 00:24:26 +0200
Message-Id: <20180410212910.981912187@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400119837448195?=
X-GMAIL-MSGID: =?utf-8?q?1597400541767801147?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Fontenot <nfont@linux.vnet.ibm.com>


[ Upstream commit 09fb35ead58cd557aa9b20576d15816bc91a4deb ]

Initiating a kdump via the command line can cause a pending interrupt
to be handled by the ibmvnic driver when initializing the sub-CRQ
irqs during driver initialization.

NIP [d000000000ca34f0] ibmvnic_interrupt_rx+0x40/0xd0 [ibmvnic]
LR [c000000008132ef0] __handle_irq_event_percpu+0xa0/0x2f0
Call Trace:
[c000000047fcfde0] [c000000008132ef0] __handle_irq_event_percpu+0xa0/0x2f0
[c000000047fcfea0] [c00000000813317c] handle_irq_event_percpu+0x3c/0x90
[c000000047fcfee0] [c00000000813323c] handle_irq_event+0x6c/0xd0
[c000000047fcff10] [c0000000081385e0] handle_fasteoi_irq+0xf0/0x250
[c000000047fcff40] [c0000000081320a0] generic_handle_irq+0x50/0x80
[c000000047fcff60] [c000000008014984] __do_irq+0x84/0x1d0
[c000000047fcff90] [c000000008027564] call_do_irq+0x14/0x24
[c00000003c92af00] [c000000008014b70] do_IRQ+0xa0/0x120
[c00000003c92af50] [c000000008002594] hardware_interrupt_common+0x114/0x180

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2209,6 +2209,12 @@ static irqreturn_t ibmvnic_interrupt_rx(
 	struct ibmvnic_sub_crq_queue *scrq = instance;
 	struct ibmvnic_adapter *adapter = scrq->adapter;
 
+	/* When booting a kdump kernel we can hit pending interrupts
+	 * prior to completing driver initialization.
+	 */
+	if (unlikely(adapter->state != VNIC_OPEN))
+		return IRQ_NONE;
+
 	adapter->rx_stats_buffers[scrq->scrq_num].interrupts++;
 
 	if (napi_schedule_prep(&adapter->napi[scrq->scrq_num])) {
