Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226A0uvKZNChmvztaBWE0ygjBa41zyqbGlxduSePIqHubU4j/2La353/B3jYeA46g0PDJpEd
ARC-Seal: i=1; a=rsa-sha256; t=1517590895; cv=none;
        d=google.com; s=arc-20160816;
        b=JEOU9OMcykwt0ps/ky45PLnKPb+9tBn0hWhULNwShuXBhQgqrRV6nNn+yWyeIKjaOZ
         1rJdIdG+yUaaogHlrddDt6gFmF81B8ODvKcLEGmWR1WL6AdzFrtBovv8Gty7YpYWTbdk
         czzIl6y1NHl1MdGYe9kAGZJVkhM0MyrMg9PehbF+l3V1AkLKBXODqIyKWTFeLOj0bQbB
         dEWC3w6rIPFZpkteLPfgedpybO6AWZYfVNjSvjcgdWOYzUckbVUtDZWL2VB2sAfRMhEM
         ibs0e3ZgS1MjF1UGaJDm9H3qu3WDo3ePli3A8B9HuNsOYOdCaujzfuFJdT97E+akJ1J5
         znlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fRIbjXh9vVQViak/bF2/qIDOwTr+sMxx0vD6ej7Y7ko=;
        b=XrZVVNSoDzu9uZCdQFaPoB27kwbluD4+G9FDOCSCRrMla27Cf8hHKYO5rMuvBoX7sq
         Sq8kNdAhwfEdBp5+nQNFlAeKTXv9D/cElu3liNrNoxbe5Dso0RjbQpXdJILkRxWTt+Sd
         hppRnZsg6m2ZINc3lFWXWes2IfK7KZia1ls/EasODWMMQDMJRl8E7wCCg4mFIoRmMnCp
         iqmB33rhqNzbDooEQMnC/j1DxvwJxz+FuI5XsePmFv/0TTIfklO/s/qeb5hhFElbC0Nu
         CR9+pZQft5oDYyhVgg5b9nIoEJO12m2myZMQjviuHZbPHD2HtQgA7AAjE69FREfzjyAu
         tw1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
	Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 50/67] scsi: aacraid: Prevent crash in case of free interrupt during scsi EH path
Date: Fri,  2 Feb 2018 17:58:19 +0100
Message-Id: <20180202140820.869816404@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309390426445921?=
X-GMAIL-MSGID: =?utf-8?q?1591309390426445921?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>


[ Upstream commit e4717292ddebcfe231651b5aff9fa19ca158d178 ]

As part of the scsi EH path, aacraid performs a reinitialization of the
adapter, which encompass freeing resources and IRQs, NULLifying lots of
pointers, and then initialize it all over again.  We've identified a
problem during the free IRQ portion of this path if CONFIG_DEBUG_SHIRQ
is enabled on kernel config file.

Happens that, in case this flag was set, right after free_irq()
effectively clears the interrupt, it checks if it was requested as
IRQF_SHARED. In positive case, it performs another call to the IRQ
handler on driver. Problem is: since aacraid currently free some
resources *before* freeing the IRQ, once free_irq() path calls the
handler again (due to CONFIG_DEBUG_SHIRQ), aacraid crashes due to NULL
pointer dereference with the following trace:

  aac_src_intr_message+0xf8/0x740 [aacraid]
  __free_irq+0x33c/0x4a0
  free_irq+0x78/0xb0
  aac_free_irq+0x13c/0x150 [aacraid]
  aac_reset_adapter+0x2e8/0x970 [aacraid]
  aac_eh_reset+0x3a8/0x5d0 [aacraid]
  scsi_try_host_reset+0x74/0x180
  scsi_eh_ready_devs+0xc70/0x1510
  scsi_error_handler+0x624/0xa20

This patch prevents the crash by changing the order of the
deinitialization in this path of aacraid: first we clear the IRQ, then
we free other resources. No functional change intended.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Reviewed-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/aacraid/commsup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1363,13 +1363,13 @@ static int _aac_reset_adapter(struct aac
 	 * will ensure that i/o is queisced and the card is flushed in that
 	 * case.
 	 */
+	aac_free_irq(aac);
 	aac_fib_map_free(aac);
 	pci_free_consistent(aac->pdev, aac->comm_size, aac->comm_addr, aac->comm_phys);
 	aac->comm_addr = NULL;
 	aac->comm_phys = 0;
 	kfree(aac->queues);
 	aac->queues = NULL;
-	aac_free_irq(aac);
 	kfree(aac->fsa_dev);
 	aac->fsa_dev = NULL;
 	quirks = aac_get_driver_ident(index)->quirks;
