Return-Path: <gustavo.pimentel@synopsys.com>
X-Google-Smtp-Source: AIpwx4/OuzAcQ3Uv/wt0O4xQLpO/asIqIY10nohgOobXg8BVb4lTGzBFje4WBWSJrq03xH+QilOY
ARC-Seal: i=1; a=rsa-sha256; t=1522331624; cv=none;
        d=google.com; s=arc-20160816;
        b=MCBca5M/nU2hZZl24JHf85saGiiBK8qw+JPQUhxwbm+0VKYHIj69gUOlUZCRXW6PGs
         qQxaNQCzJEGApV3N0fpyyzVmOYJTQ/IofE98dW4GUzUTZ+Mr+z80YKYt0cZNmb184igN
         5+U4aRSDWSS1YVZ7BVYD8kPIiYkfSZIGAHRXP5oU75R+s+zvbWDqIkYA6MF9vfEC+g4C
         k25cyLFxGaOYPWfPUVoShjM/kkXeUD33tWY1ICwgsGTYCH/jbs/I6g/d1TfJ/GrT80D6
         Lq7fNjAxK2pW4C/oXDh3yv+ZYwDYm7HYcI1+BDWGBIi+8htM/RrRpOsLzuQbYAAJKSdJ
         3u8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=yUZTJ0IozgzYHx77ZRcEJltoAQtMO87+N0/4UJ2HFTY=;
        b=aeMVolYGtV5+JgPVigpwciAEy9ayxjzXlfbLl47q8RxOEE5rIRsRU/ZFncb2wmDdfS
         SA0jN4//RP7ArsQq1rzxjGlMIm7CqyS6gwapDJdjYTI9QGWEEP9fc0x9Ww0bE5Kll67K
         XpAD7RBOn3j/uQzg/nDED8ym4kmCCVvFLUfTAcNPEYJpZY1GlJMgQTMpKoshptQUHJRi
         5+5FBfBu3WdhWDPGvVEiuIpJB3xMT5R0F4HgcKlCFZ/5QpR6WF2sqe3oXwGNQPRFq6wt
         +QK1IADelfFw68WvsbSyepq4JQPdTiBh9FvOPHB9wGnp9/s8CPx6qEuCfs5/cNu2/+3C
         pjSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of gustavo.pimentel@synopsys.com designates 198.182.60.111 as permitted sender) smtp.mailfrom=gustavo.pimentel@synopsys.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=synopsys.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of gustavo.pimentel@synopsys.com designates 198.182.60.111 as permitted sender) smtp.mailfrom=gustavo.pimentel@synopsys.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=synopsys.com
Subject: Re: [PATCH v5 00/12] PCI endpoint 64-bit BAR fixes
To: Niklas Cassel <niklas.cassel@axis.com>, "kishon@ti.com" <kishon@ti.com>,
 "cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Douglas <adouglas@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Niklas Cassel <niklass@axis.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <e2fb68a0-c860-71cc-1983-2ecf30d5a2aa@synopsys.com>
Date: Thu, 29 Mar 2018 14:52:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328115018.31921-1-niklas.cassel@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596182050655819288?=
X-GMAIL-MSGID: =?utf-8?q?1596280405002833815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Niklas,

On 28/03/2018 12:50, Niklas Cassel wrote:
> PCI endpoint fixes to improve the way 64-bit BARs are handled.
> 
> 
> There are still future improvements that could be made:
> 
> pci-epf-test.c always allocates space for
> 6 BARs, even when using 64-bit BARs (which
> really only requires us to allocate 3 BARs).
> 
> pcitest.sh will print "NOT OKAY" for BAR1,
> BAR3, and BAR5 when using 64-bit BARs.
> This could probably be improved to say
> something like "N/A (64-bit BAR)".
> 
> Niklas Cassel (12):
>   PCI: endpoint: BAR width should not depend on sizeof dma_addr_t
>   PCI: endpoint: Simplify epc->ops->set_bar()/pci_epc_set_bar()
>   PCI: endpoint: Setting BAR_5 to 64-bits wide is invalid
>   PCI: endpoint: Setting 64-bit/prefetch bit is invalid when IO is set
>   PCI: endpoint: Setting a BAR size > 4 GB is invalid if 64-bit flag is
>     not set
>   PCI: designware-ep: Make dw_pcie_ep_set_bar() handle 64-bit BARs
>     properly
>   PCI: cadence: Set PCI_BASE_ADDRESS_MEM_TYPE_64 if a 64-bit BAR was
>     set-up
>   PCI: endpoint: Handle 64-bit BARs properly
>   PCI: endpoint: Make epc->ops->clear_bar()/pci_epc_clear_bar() take
>     struct *epf_bar
>   PCI: endpoint: Make sure that BAR_5 does not have 64-bit flag set when
>     clearing
>   PCI: designware-ep: Make dw_pcie_ep_reset_bar() handle 64-bit BARs
>     properly
>   misc: pci_endpoint_test: Handle 64-bit BARs properly
> 
>  drivers/misc/pci_endpoint_test.c              | 12 +++++----
>  drivers/pci/cadence/pcie-cadence-ep.c         | 15 ++++++++---
>  drivers/pci/dwc/pcie-designware-ep.c          | 36 +++++++++++++++++++++------
>  drivers/pci/endpoint/functions/pci-epf-test.c | 28 +++++++++++++--------
>  drivers/pci/endpoint/pci-epc-core.c           | 32 +++++++++++++++---------
>  drivers/pci/endpoint/pci-epf-core.c           |  4 +++
>  include/linux/pci-epc.h                       | 11 ++++----
>  include/linux/pci-epf.h                       |  2 ++
>  8 files changed, 95 insertions(+), 45 deletions(-)
> 

For the whole series:

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Regards,
Gustavo
