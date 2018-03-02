Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtxTRDV0MUNz8gwNGQW+oKfdtrUjXJ5zJbezTF2XyCwxsG3OEhtgE3LMSlyaaodjhqsJY3a
ARC-Seal: i=1; a=rsa-sha256; t=1519981486; cv=none;
        d=google.com; s=arc-20160816;
        b=K2SBwN0wvdy09DatOBHOHefbW0wLfHG91XaF0yfAyYglLJZtZZLP8cIO3ksf+U1tcg
         WgwKInnF653lkSn9VMWQNYRMK0E82o70NQlhWqBhArU9nEY2LLZv2zupeBSrtj0L7+S2
         6HpNiITjoZUuoP1z9bdXg3/Xin/r4hcKlb6C2HVhJ3v4TXQlnkN5S69AGIusvx+Gq/Y+
         6k31B2g/M8bXen/txVzcGiSncgh4OkB0CNpuCOcMx9QAdE0Z3gGnZtww14XQ62M+ZXbb
         Bt+DFosOed4mZ1K4a4GmdAS5XJKu/mGYMHs96agStlbJ6gY8VDv/PfXIbUAHKKPe7t5f
         CjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fjYy6d+o4lqgqdsqZLjXYdv7w0Lpp18K7wWqJOHj7Uc=;
        b=FwV19tZyhwGmfou5f16x6llDqT1GTzXwk0FRQb7BbsgWPBGHP96vfu06Ni/PPNxFxV
         n7vw5RuCqkVm0J7GiYY0P3PwCaSB/IfPPosPsd7n0k5aP0FwnjIqX+5Ap5t0vYcsV84r
         5hkO//cBIyf6Q0RKIGj/p/jCMTA/vfhZxQKtaIl+dR3L2APH3ZPt9gbj0KG42eZ5L0ax
         +STiPO7BdN7FC1Csfc/4uAp6NgjNucMDwOiZ59M3C17vU+TPqKEv9wII+5mIbXMo5PC2
         wtzNN9e+AbHGGh6D6xwum1B6IzP3/EtlnFKrr2C5a9xFrRhWsdI8XQJeKD56nL3TOHl3
         8cog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yuval Mintz <yuvalm@mellanox.com>,
	Ido Schimmel <idosch@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 107/115] mlxsw: pci: Wait after reset before accessing HW
Date: Fri,  2 Mar 2018 09:51:50 +0100
Message-Id: <20180302084508.170296674@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816107624577054?=
X-GMAIL-MSGID: =?utf-8?q?1593816107624577054?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuval Mintz <yuvalm@mellanox.com>


[ Upstream commit 8e033a93b37f37aa9fca71a370a895155320af60 ]

After performing reset driver polls on HW indication until learning
that the reset is done, but immediately after reset the device becomes
unresponsive which might lead to completion timeout on the first read.

Wait for 100ms before starting the polling.

Fixes: 233fa44bd67a ("mlxsw: pci: Implement reset done check")
Signed-off-by: Yuval Mintz <yuvalm@mellanox.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c    |    7 ++++++-
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h |    1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1643,7 +1643,12 @@ static int mlxsw_pci_sw_reset(struct mlx
 		return 0;
 	}
 
-	wmb(); /* reset needs to be written before we read control register */
+	/* Reset needs to be written before we read control register, and
+	 * we must wait for the HW to become responsive once again
+	 */
+	wmb();
+	msleep(MLXSW_PCI_SW_RESET_WAIT_MSECS);
+
 	end = jiffies + msecs_to_jiffies(MLXSW_PCI_SW_RESET_TIMEOUT_MSECS);
 	do {
 		u32 val = mlxsw_pci_read32(mlxsw_pci, FW_READY);
--- a/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
@@ -59,6 +59,7 @@
 #define MLXSW_PCI_SW_RESET			0xF0010
 #define MLXSW_PCI_SW_RESET_RST_BIT		BIT(0)
 #define MLXSW_PCI_SW_RESET_TIMEOUT_MSECS	5000
+#define MLXSW_PCI_SW_RESET_WAIT_MSECS		100
 #define MLXSW_PCI_FW_READY			0xA1844
 #define MLXSW_PCI_FW_READY_MASK			0xFFFF
 #define MLXSW_PCI_FW_READY_MAGIC		0x5E
