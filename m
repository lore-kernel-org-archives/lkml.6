Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx493Z/oCVPg5s0eR/kbNMdWArd2LKbhgcDzNSwxL7Ykqk3V5wcaw+EZPJdqyGc0O+BAqB2Op
ARC-Seal: i=1; a=rsa-sha256; t=1523473340; cv=none;
        d=google.com; s=arc-20160816;
        b=MvaqEpnFCRG868wp3jS7PUtjdbAtowfV9Wr/kkJBxbqjImdfzLkKhN0ctphzibavmK
         2azL7bc4XLDSlypFnyOLcuyNQihgRdtUDwOuC8MsUz5Avaa1OViaHyb1Gj3vTBJktoU5
         R67nqcxCw7jAfm7MrY18zlbWhiVH5sCVuCcafRMoUd0tpbLDe8yjoNFP9LRZXAEV8nop
         B6nG6a4ewHdSZWaaO8CnrjQhEcTfanOCd7VkN3/veGQ7emtOE9QOO6JBSluvp574e+h4
         H8KS7OJRGPqJQZCgQmuXOipfvihTVExTas70diFFerk9s0g0gM7j/XQUrkMbCDherfSC
         Okcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nbHrawYj0TRjTA/zg5mLoGMFtvduviQj/CUy9nyo/uQ=;
        b=ELW3EJv+Ej43m/eYSskNo6Ce9sJZ9VDLdxsKUU8An+t72Dyrl9LY3BdkvjYC2HpIh/
         61VU2/AQyIuWAg79mSeXm/g33Ua+WvUqQVOC6QWQzSF4HZZHJlXs+F8y41qzkOBdmOrZ
         bU/JEGKfr3LN3fU1gQadZ+tw1p7mmpPEXnzGlF0SFEkAyB84dcncERoHPXtO6yt/3E4a
         s2jHXnlZMjnfD/ZmB+UvVXaS2GGP2x6KleYlsW0rCEzUtqL9rUtXANaQJW2n/bxeYs0x
         79c+hfhGENvB/SSi0kg48O0Ix36FVF9BdGMUlUQLjk6APw0n7jlrfkS5tboFzG4quGoD
         VlUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@163.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 178/310] qlcnic: Fix a sleep-in-atomic bug in qlcnic_82xx_hw_write_wx_2M and qlcnic_82xx_hw_read_wx_2M
Date: Wed, 11 Apr 2018 20:35:17 +0200
Message-Id: <20180411183630.273396108@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476204102240677?=
X-GMAIL-MSGID: =?utf-8?q?1597477581639620086?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Ju Bai <baijiaju1990@163.com>


[ Upstream commit 5ea6d691aac6c93b790f0905e3460d44cc4c449b ]

The driver may sleep under a write spin lock, and the function
call path is:
qlcnic_82xx_hw_write_wx_2M (acquire the lock by write_lock_irqsave)
  crb_win_lock
    qlcnic_pcie_sem_lock
      usleep_range
qlcnic_82xx_hw_read_wx_2M (acquire the lock by write_lock_irqsave)
  crb_win_lock
    qlcnic_pcie_sem_lock
      usleep_range

To fix it, the usleep_range is replaced with udelay.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
@@ -341,7 +341,7 @@ qlcnic_pcie_sem_lock(struct qlcnic_adapt
 			}
 			return -EIO;
 		}
-		usleep_range(1000, 1500);
+		udelay(1200);
 	}
 
 	if (id_reg)
