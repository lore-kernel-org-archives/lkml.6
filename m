Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Vl/uzRPEdIRr82dQa3qP5m6SZ913lqwTu3m4DMAkJMefSNdXUAGaJCzkbWqge06doKKyH
ARC-Seal: i=1; a=rsa-sha256; t=1523473028; cv=none;
        d=google.com; s=arc-20160816;
        b=uJMUYrj9dIq5N/RsyupOdu3SDh69fqpcyPQRTMoHL62iF7SRfUKE+adaWoFvQ9crks
         Zf9hd8YE0r2pBh0jdgOicJgMZRhQyKNpGwzMXtMQkNAkhtOBuilxHF4ZpPVJr0oNnS6q
         tkFNyUjLokjOx/MDP++fqxF2ioUeqMgCduWd7Zy/d0Qvbj0w/ZKhgMUsWhLxdQaS7Hb3
         tCzim5h0DxVx+44v2Is/CfTy897IwHnBjUF/p8nKLg+yEgttPjqG1hY2/E60PgedQzMN
         3cKCxslO2PlCFmPh3rDfFau3rNWcbZpIWtC0oghEAiPs9jykE2yUYgg1d9onOhVL/WUZ
         2HbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=166T+5sSq2G0iGjlZ0OKv0rkP7sdgTe+7n88vSB5my4=;
        b=sazD+VCNY0/qcpFZZeGy26W0o8eo4MRySt8wOygEDvQGV4Qw6TdO/3FmnFMZK0vul0
         ynAn/qdt7NjUxJC01/RH0nBtRS4eF1FDc2RRThLYHnnBLF9AeOaJub2sfBz6po91xM1O
         bKQ3oM9qSXbale4OCAnsV2NqEXpuJ6q3P2ZqwJhhh9eNJmhEqffOAttlZIkn9iBOEB9j
         lbpRoAEos3R7cUTs9ELlK4GteUkwvmHAZWxazwcikHXGfSMYoVlKr6liVtAPwZxTsrAQ
         rRGs+dCICeh0uet1gJfBJgB645hpbx/3AjF61Ai329Ni5rkQvdK0PxRfLM3DSJT2gXvQ
         Ksog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 069/310] USB: ene_usb6250: fix SCSI residue overwriting
Date: Wed, 11 Apr 2018 20:33:28 +0200
Message-Id: <20180411183625.289339931@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476114116692193?=
X-GMAIL-MSGID: =?utf-8?q?1597477254125738984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>


[ Upstream commit aa18c4b6e0e39bfb00af48734ec24bc189ac9909 ]

In the ene_usb6250 sub-driver for usb-storage, the SCSI residue is not
reported correctly.  The residue is initialized to 0, but this value
is overwritten whenever the driver sends firmware to the card reader
before performing the current command.  As a result, a valid READ or
WRITE operation appears to have failed, causing the SCSI core to retry
the command multiple times and eventually fail.

This patch fixes the problem by resetting the SCSI residue to 0 after
sending firmware to the device.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: Andreas Hartmann <andihartmann@01019freenet.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/ene_ub6250.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -1942,6 +1942,8 @@ static int ene_load_bincode(struct us_da
 	bcb->CDB[0] = 0xEF;
 
 	result = ene_send_scsi_cmd(us, FDIR_WRITE, buf, 0);
+	if (us->srb != NULL)
+		scsi_set_resid(us->srb, 0);
 	info->BIN_FLAG = flag;
 	kfree(buf);
 
