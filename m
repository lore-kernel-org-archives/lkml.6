Return-Path: <niklas.cassel@axis.com>
X-Google-Smtp-Source: AIpwx4+5M7eGOMAXJq1Q/4rA6HLYyAYcL1Hf3cknQGDGYI3+ZRO0kYOD6cRlJIm+BfJNNd+RKQ7c
ARC-Seal: i=1; a=rsa-sha256; t=1522237825; cv=none;
        d=google.com; s=arc-20160816;
        b=E0fkMhfkGxyD3kceZlQnEaYtfwGLjI8zGeG1Cg0gXPBlrMR+psiwgjdXIdzSGhJOYX
         7Oiuho1HDJwG5TfekMlmZE1bChKetNvfhQnfNWnAp0VieOQ9cVO9Wl3rMTC/U67xoQ77
         TRdTJ+hiBFjmsUSznKJEJZn7rT/cPTeE0msSO8KxACecrB+qQzlf9MY0pueTUUYjofYT
         TnMaJDw15gUrNTqDPpqBrtE3tKOAQprAc3S2oe+ALBtKWLnuMdS5/qSVDCeYtc6YaYV2
         J6nVAMl4iHJZdeOWjsR4RveRBFySCNZwPo2CMTAZ2kTj323tMgcwMufczsgrwxM0oIbq
         qmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=aLL86EvzuBfi0hiRJeW3kU7TVQVp1r3OUC6YmiGgwfs=;
        b=Tw4q4fRJYrR4JI2Z4HGoDSVAcSkkjItXVfG+M0ajkRiQY7hBwTzi9SpyKinaY1CuOR
         QgEjy6vAn0u3UT1R1EihgKsbywvEhCJhlnlGMj5oz4ri9AZsIiaiaEcpgh+vJ6+n+th/
         kr1fn8Jrwz0W15aausbxj12v8c6ecphoAYqXLsN5ImegSAUJ+5o+qbACVxMoGleRCz40
         vk30sH1xgvOvJdqYm/Jyt9pLy9LIICpJW68UKg55DX5EbbTqpPhX1sBj9MLMIGTKzPOt
         isc/J2hhlZ8ldnJAvcYdJ+FjNf34cvO7wEAqa5fS2ArM8j1QJiA5A/6nL+ZrdSn7QPqK
         l3mA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of niklas.cassel@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=niklas.cassel@axis.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of niklas.cassel@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=niklas.cassel@axis.com
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com,
	cyrille.pitchen@free-electrons.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Douglas <adouglas@cadence.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/12] PCI endpoint 64-bit BAR fixes
Date: Wed, 28 Mar 2018 13:50:05 +0200
Message-Id: <20180328115018.31921-1-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
X-TM-AS-GCONF: 00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596182050655819288?=
X-GMAIL-MSGID: =?utf-8?q?1596182050655819288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PCI endpoint fixes to improve the way 64-bit BARs are handled.


There are still future improvements that could be made:

pci-epf-test.c always allocates space for
6 BARs, even when using 64-bit BARs (which
really only requires us to allocate 3 BARs).

pcitest.sh will print "NOT OKAY" for BAR1,
BAR3, and BAR5 when using 64-bit BARs.
This could probably be improved to say
something like "N/A (64-bit BAR)".

Niklas Cassel (12):
  PCI: endpoint: BAR width should not depend on sizeof dma_addr_t
  PCI: endpoint: Simplify epc->ops->set_bar()/pci_epc_set_bar()
  PCI: endpoint: Setting BAR_5 to 64-bits wide is invalid
  PCI: endpoint: Setting 64-bit/prefetch bit is invalid when IO is set
  PCI: endpoint: Setting a BAR size > 4 GB is invalid if 64-bit flag is
    not set
  PCI: designware-ep: Make dw_pcie_ep_set_bar() handle 64-bit BARs
    properly
  PCI: cadence: Set PCI_BASE_ADDRESS_MEM_TYPE_64 if a 64-bit BAR was
    set-up
  PCI: endpoint: Handle 64-bit BARs properly
  PCI: endpoint: Make epc->ops->clear_bar()/pci_epc_clear_bar() take
    struct *epf_bar
  PCI: endpoint: Make sure that BAR_5 does not have 64-bit flag set when
    clearing
  PCI: designware-ep: Make dw_pcie_ep_reset_bar() handle 64-bit BARs
    properly
  misc: pci_endpoint_test: Handle 64-bit BARs properly

 drivers/misc/pci_endpoint_test.c              | 12 +++++----
 drivers/pci/cadence/pcie-cadence-ep.c         | 15 ++++++++---
 drivers/pci/dwc/pcie-designware-ep.c          | 36 +++++++++++++++++++++------
 drivers/pci/endpoint/functions/pci-epf-test.c | 28 +++++++++++++--------
 drivers/pci/endpoint/pci-epc-core.c           | 32 +++++++++++++++---------
 drivers/pci/endpoint/pci-epf-core.c           |  4 +++
 include/linux/pci-epc.h                       | 11 ++++----
 include/linux/pci-epf.h                       |  2 ++
 8 files changed, 95 insertions(+), 45 deletions(-)

-- 
2.14.2
