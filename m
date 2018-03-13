Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtUSwSJimbhixhK3oCcF4wcEz8DhE2FfOHJAR5eRWicbBIymLMuKXWO86sOMMut8ZGdA121
ARC-Seal: i=1; a=rsa-sha256; t=1520954987; cv=none;
        d=google.com; s=arc-20160816;
        b=ROzkD34/Z6OlgxiIOCVL5tP9Pi4fDPb5+FOzFYyNxwZv+2t+SSSjo2moLjXAc31nWT
         xDz6VH473/84u//QWDBV2wlTrmrQnm6FQ9cJJ1geClV7Naa9k+jNl/IIALjz9Ql4gldt
         NrVJ//Yqs3W2Qj5ItJdSolXdPGDKpZzvW4Jcy1rw+VhpBVPDMGd/mB5qV2iOEtRmHv2Q
         jOPpOFo2HNqWLvlPFS6NTgUDaDHJT0b8BeCmPVHKZyLvxY6OwR2+V6IonQkm8N8jhJWT
         tob+PUDelZFwJjCU+D7vfNC2T+zP9PSvjf94nMos8U0WcHPVj+Np6chJKUvy2WUs69o7
         eYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7Bggj7JWEV9fUfzRYLEIYBLvqbzhRGiC5PdQ04wNUzs=;
        b=QEICaSiUIbCgi8+dS/BWQgtWi/hchyy3f3Y7useDl74X+DTLVRVVnBkHUhNYDgUEeW
         VFhwnQ4wimwrrF0rr1ZbaxES2Ajiqfwy39MlXT7YyCtHkDfNHjSlwy5mag6hBhflLZgP
         JO/cO3L+/uTcBV+5h5aD0qzqoCP9kBfR0W+KiaRGNSkc6OjX5psytV4Jv2pMJU2bENDC
         z1ow+nj/bGmsAmrVg8Z0pYgQxLHm0eLj2zF20adAHJgy/vjpYAJeRPs7iZExjxkeN8bk
         XWbXT/1r6CpLU0epFqG16YhIBdD7QfOLNTBsuSTeDbzJ2thIsRm3AXagb1yfcbhXjWEf
         xfTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Niklas Cassel <niklas.cassel@axis.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
	Koen Vandeputte <koen.vandeputte@ncentric.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jianguo Sun <sunjianguo1@huawei.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH 4.15 043/146] PCI: dwc: Fix enumeration end when reaching root subordinate
Date: Tue, 13 Mar 2018 16:23:30 +0100
Message-Id: <20180313152323.908540178@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836897125787265?=
X-GMAIL-MSGID: =?utf-8?q?1594836897125787265?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Koen Vandeputte <koen.vandeputte@ncentric.com>

commit fc110ebdd014dd1368c98e7685b47789c31fab42 upstream.

The subordinate value indicates the highest bus number which can be
reached downstream though a certain device.

Commit a20c7f36bd3d ("PCI: Do not allocate more buses than available in
parent") ensures that downstream devices cannot assign busnumbers higher
than the upstream device subordinate number, which was indeed illogical.

By default, dw_pcie_setup_rc() inits the Root Complex subordinate to a
value of 0x01.

Due to this combined with above commit, enumeration stops digging deeper
downstream as soon as bus num 0x01 has been assigned, which is always the
case for a bridge device.

This results in all devices behind a bridge bus remaining undetected, as
these would be connected to bus 0x02 or higher.

Fix this by initializing the RC to a subordinate value of 0xff, which is
not altering hardware behaviour in any way, but informs probing function
pci_scan_bridge() later on which reads this value back from register.

The following nasty errors during boot are also fixed by this:

  pci_bus 0000:02: busn_res: can not insert [bus 02-ff] under [bus 01] (conflicts with (null) [bus 01])
  ...
  pci_bus 0000:03: [bus 03] partially hidden behind bridge 0000:01 [bus 01]
  ...
  pci_bus 0000:04: [bus 04] partially hidden behind bridge 0000:01 [bus 01]
  ...
  pci_bus 0000:05: [bus 05] partially hidden behind bridge 0000:01 [bus 01]
  pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 05
  pci_bus 0000:02: busn_res: can not insert [bus 02-05] under [bus 01] (conflicts with (null) [bus 01])
  pci_bus 0000:02: [bus 02-05] partially hidden behind bridge 0000:01 [bus 01]

Fixes: a20c7f36bd3d ("PCI: Do not allocate more buses than available in
parent")
Tested-by: Niklas Cassel <niklas.cassel@axis.com>
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Lucas Stach <l.stach@pengutronix.de>
Cc: stable@vger.kernel.org	# v4.15+
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Jianguo Sun <sunjianguo1@huawei.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Minghuan Lian <minghuan.Lian@freescale.com>
Cc: Mingkai Hu <mingkai.hu@freescale.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/dwc/pcie-designware-host.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -607,7 +607,7 @@ void dw_pcie_setup_rc(struct pcie_port *
 	/* setup bus numbers */
 	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
 	val &= 0xff000000;
-	val |= 0x00010100;
+	val |= 0x00ff0100;
 	dw_pcie_writel_dbi(pci, PCI_PRIMARY_BUS, val);
 
 	/* setup command register */
