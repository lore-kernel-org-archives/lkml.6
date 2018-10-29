Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC0FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F5320657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="ExDOzoNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F5320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJ3A6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:58:48 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:45480
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727565AbeJ3A6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww16xEFoi2Y3SX+TjHFea0C6UHRKmaoh4Ftbks4WJks=;
 b=ExDOzoNWES+TFeuFNqjOpXGZcuDFshRvsuCAuEWC658srgdmkTvDN2pNt/zrk7oK9nkDmyAp0fQofQtZRGe0OEQ1ZhvDwMWQ/BugnfnBbD5f8OZjEgUlcYO72F9QBtg21e3l5VdSAdldkFW+BICZzU9JNpR1VnU7O7/PeKtUn+4=
Received: from AM6PR06CA0020.eurprd06.prod.outlook.com (2603:10a6:20b:14::33)
 by AM6PR0602MB3526.eurprd06.prod.outlook.com (2603:10a6:209:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.26; Mon, 29 Oct
 2018 16:09:23 +0000
Received: from VE1EUR02FT044.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::203) by AM6PR06CA0020.outlook.office365.com
 (2603:10a6:20b:14::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.21 via Frontend
 Transport; Mon, 29 Oct 2018 16:09:23 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; gnudd.com; dkim=none (message not signed)
 header.d=none;gnudd.com; dmarc=bestguesspass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT044.mail.protection.outlook.com (10.152.13.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.14 via Frontend Transport; Mon, 29 Oct 2018 16:09:22 +0000
Received: from cernfe04.cern.ch (188.184.36.41) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 29 Oct
 2018 17:09:23 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Mon, 29 Oct 2018 17:09:22 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Alessandro Rubini <rubini@gnudd.com>, <gregkh@linuxfoundation.org>
Reply-To: <federico.vaga@cern.ch>
CC:     <linux-kernel@vger.kernel.org>,
        Juan David Gonzalez Cobas <dcobas@cern.ch>
Subject: [RFC] Proposal for FMC Subsystem Eradication
Date:   Mon, 29 Oct 2018 17:09:21 +0100
Message-ID: <2839902.VaCsmBvZoB@pcbe13614>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(2980300002)(438002)(189003)(199004)(45074003)(126002)(476003)(356004)(15974865002)(478600001)(86362001)(106466001)(50466002)(43066004)(316002)(3450700001)(8676002)(786003)(26005)(106002)(486006)(16526019)(426003)(186003)(33896004)(8936002)(4326008)(47776003)(44832011)(54906003)(7636002)(7736002)(110136005)(246002)(305945005)(97756001)(14444005)(561944003)(33716001)(6306002)(9576002)(336012)(9686003)(74482002)(966005)(2906002)(23726003)(230700001)(46406003)(107886003)(6116002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0602MB3526;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1de92a6a-2ed1-4ada-d7c4-08d63db8e433
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:AM6PR0602MB3526;
X-MS-TrafficTypeDiagnostic: AM6PR0602MB3526:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0602MB3526;20:t35oogVsrWthjyT+GOt7loKgb9pIjtk/D0yN6GpktdqU+MYHwiS9nNyUmFmkqHeAI8VGPI0FD0xGCzJrCDt4M61iNQTiV9s6hczfLglT47nAXQn8ovfVVoCOm9Qb3HuwlqHS0/BQ1ZiLVcKkRGY6CkDI2FzMrKNRc/SECIT9l4/sA0Y48yH7u3MhmZHHuMcAi4cmllOrDgpfzo3icIuqhczF+drDcG7ggzQ5gyWu+/jc2IKFMA6ftQTQ/x+tAnkYW68vM/NcMAG0pcJmtSUzcPRYeqh01+Ls0UEdwuLo190R1GXvFCr4iRF+jxJu6/A13wBFPFEuV7lKBKmMS9iKBG5aY+Oe7AABjmWsJysToOc8+6YNGzcQghs6zSvMQ/qCfxq37JBlvbwBhJAyUr5PVx+BK/3kPEf/AoKQH89VEl76XhAH+REiNwfuhyMhBmwQDptzKLxYJGg3PZQwdgzjBFqbFAoiIWP+OhoimfOso88vwwzAbrasZp4sItOT7axO;4:zYGAOxqsOAmYvig5qhx9VVBxClkAo9XXRXLXGaWN8OrII205HpORQu2m/iXCBcny9/YXtEfB8qkFvzcBXO/HgxfP6Om5P+AEE6dKy9uHh45e0f/kDnQeT9lYwoc+AeUum0pD8P/6pArdkpPnqoCq3khTDxFQpDpulobj1kksa8iBSmzoTPoTh+EewrhWPC6RCvAJmBm/qUikufCVoyJRI6glCYjzPwcwkGwNArUOx3JSGJz7IVQPYgAJrkoDr3naPt3Zlu7OzN8Z5QU2lhLB1o/f7seJE6Cfytot2O7NpcCcsIJDkrFGe1iCx4MjuEao9s3NRLv5JtFeveghWyYrPtmUkLF4Q3IFRIOAF0F/K07LJ67+xCfbaxAv0pGtb3lzV0NTxpuNMigcHg9PBlx7xUH+c/6459C4mV6q92FQreU=
X-Microsoft-Antispam-PRVS: <AM6PR0602MB352659081865558DE997AB92EFF30@AM6PR0602MB3526.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397)(788757137089)(270512070085399)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6PR0602MB3526;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0602MB3526;
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0602MB3526;23:eujJ7xPJebfhqkgA0f8PFC+nxE6Cnh8BpshMB1P?=
 =?us-ascii?Q?fZj+P9bNRQecJFIM6ZvSO/E0wt9OjMEUrIiZHiZClkd+imOcyLbi9BbvBmjU?=
 =?us-ascii?Q?IDQK63CTtJVB38Nlfc6hhv+LcZukLgyOBZXBvCl/RrAWlBNizXL7odyReFn9?=
 =?us-ascii?Q?13wa33g8nYvXby/E5sp2BonzYzgLSRl/z1pRY+cfdmZiHwHGDkEZpUU9tIBa?=
 =?us-ascii?Q?AgjsMJLJtT9gnAy7x3+6VzJSwRWbzt+J10yeU3bag20jvNgHlVmsfJ50Bk+X?=
 =?us-ascii?Q?MMPcN98z1Go+fK+NB+QCnXgSkA06b6nqggp8quTzYPzfeetVjIBTdWgJvtn6?=
 =?us-ascii?Q?XIeYuLiupUHhbVwM5OmmEXfU5S7ojqvSmKoywphD7JSF+iSCjUd7Vr9Dn6BO?=
 =?us-ascii?Q?2+rPBUed3xSlCtvIT2BeQCwQCF2f/9K2to50PtHhg54j3LrOfK12+UNqhLfl?=
 =?us-ascii?Q?MUFaUll+JfjJJ3WIYrJvYfO94p5E5N9cQxkfL1aG/AIJVC4fCPiMFtFqJnSW?=
 =?us-ascii?Q?5lI+OZ5r2h6B/m6NS5O6mK2Hq0hHL3NwVOOXbB6qFOEsXvBeqzcEi42XF25Z?=
 =?us-ascii?Q?iarF4ioItB9gthOrVZGQp9WwbsoIbJU2i7dUcmPEMQ7KvwEpiA4SNzKaLqJM?=
 =?us-ascii?Q?B+02SKpaQpCODhPNQqf3NPNlRSiG9vJTfkfm+gN3lnbbE2jOtcF0OY4AwibK?=
 =?us-ascii?Q?uHSraO1r91n99O2nuPxlzOk6UU7VglyECzX8sUTKATJyeGxXpp0EitLMGKGt?=
 =?us-ascii?Q?AovE+BqVZ7phqzS2P2rbkVCKa1hFizUP+qCxQqhWlMe1UwzAEuKZgNyg987f?=
 =?us-ascii?Q?tITZUTIIBnRqk41Kfnj6v52JW13VOeCWBcg7hdSa9qZczLRKYjpSnGbM72rP?=
 =?us-ascii?Q?himtFlQkxWa9XoIH4Se8+9+Lyxro0HPQQ4K/FC1pRU36oFkH+1JTAuEY6yCv?=
 =?us-ascii?Q?cB5bZo4W6rdIHi1nhy/Qn7Z5QRAkwfDkt6n2yvgBN9GXdL5ubaXuKY9VVDmu?=
 =?us-ascii?Q?xePrm22jjluExAWYB1N3YFmipi0SExip8cuxE/TidBBn3Lwgs+TOXWyfRppG?=
 =?us-ascii?Q?iQeR30/0/wVVnCYtYY/dqT0Z6pTcaOai2FLY8iA0RZHqHjevWnaQ4EjUWBZw?=
 =?us-ascii?Q?do6J3ND24KcwI0VC7mabGtB+/SQCg9PwUoRpvoAn9k6DQsAVsvgfNSbK+Ijb?=
 =?us-ascii?Q?Xpyzf2/v6+K4Q5WOI0eXbnP1pF0u+YRhw2GG/MX9qSVNaBlEjq6yoicV/LXJ?=
 =?us-ascii?Q?Pl8PyzePJ2vbShEgEi2k=3D?=
X-Microsoft-Antispam-Message-Info: fBQxkyolMgRMls8l5fdJP0xdD6Ig5dhfSCSfdXS3B6a9hY5CpZCXaiNuJw9t5V82kZYfFMX5QUM0UZGX+fhFsdbDo73dRqJ9BW2Hy85PRfdxA1P+oNpz7fe1comBloPnd9CzD4aDBm7pXzwQb5CGnT1NKlwOAux/SQMbItHeFzJKitnJmvxRZ0uT8jtOV87RbHwR7VBoHxi99ugn2C8N6FwbwbXjBg8g5XXVy0Oj2LeOMoh6wO8OL++oNSuMVjRQQ8xv90aSe4hrtMlcOhwVYiEA0VMuU1KYZV5+nyrEsjzJ9SD6J1dM1EaR0Dl9EESxaJxK8xZwtJPXVwY16UikavhTt7coPzgbXMP0y8vSU6s=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0602MB3526;6:34awuAlSAzHqcs7o3fKKcaLs+q/TXSt0jN3WM3+dGwCaDr5UZHa7a3kE5UrSUoFnORibQDvc0UZxeSgLmxOtZaJl8+QyOJBql6HNAWJ3yQpYlcP7AMH5HMslXVuOrr3jsFjNtlE5zO902qYFa42+oNnOFl1pON2l11EKCrEF+i8v1PnRlv6YocTECmkz10OpOPHOyjuKcyzTi8HwGMSQIpozJXwwNrTDX0Zkn+5G6BsD4pCSDOhMgp2VDD6oyu4ZucDSLpqXTL8DYFI8CuVdvpcMc4SkNF6p3hVcuch/wJoXtYPt9D1vSXLTmlJlOWx/4RwUngZlAs6k8ZWJP0j/UYySldSqFSrd4tQM6iX0TmKJaxUY3ZefEtHRAh6W/Q2Ak+yLAOkqcaXR7TPJSAVU2bGMC/Pv37WoO6fuvGv5YdEM2fcg0GVYCP1tIavpsPRrN5F31bE1wLhmQHCzY176/w==;5:VEY8It51gNXFtuqlDML9M555yM4JtcLfrr84G7f+3k3zQRA5Xs2CzGUiXafegp2JB6iLdndbL0LUUapMt4zm9AglchndxFdofyPg8GDUZ8wrak74eTqnKJhP2F/jaRXVjPBZ+DVjhH2Ez454I4Wgs/Surb6r88UNdcY1PTiwPys=;7:dFJ6X3VOFwIpKrf3L6BvYZNRsFgF620UIMllcKtnS/JY6Zh437+iGpN2uEQ3pc1bklvxhP+tfM/aVaOISEEYtOb6g1/9QSbsPHZ9EArbfgwbzl1YeUs0WnjKBj00MwN2/RacXaeHz128DhvwexyeEA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 16:09:22.8414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de92a6a-2ed1-4ada-d7c4-08d63db8e433
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0602MB3526
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=======================
The fmc-bus Eradication
=======================

The *fmc-bus* Linux sub-system was developed under CERN supervision
around 2012. During these years, the fmc-bus has evolved and drivers
for particular FMC applications (FMC DEL, FMC ADC, FMC TDC, etc.)
have been based on it. The sub-system works fine and it is running in
the biggest particle accelerator on Earth without major problems.

Despite the fact that the fmc-bus works, the faults in its design
reveal, with the experience acquired, that its use is unduly limiting
and, actually, counter productive.

The purpose of this document is to explain the rationale behind
fmc-bus eradication from the Linux kernel mainline and to propose a
better alternative.

The fmc-bus
===========

The FMC Standard
----------------

The FMC standard (`VITA-57.1`_) describes FMC modules and carriers
from the mechanical and the electrical point of view. `VITA-57.1`_
also specifies the information stored in the (mandatory) EEPROM on the
FMC module.
On the other hand, `VITA-57.1`_ does not specify at all how FMC carriers and
its FMC modules communicate.

From the software engineering point of view, the most interesting parts of
this standard are the following chapters:

5.5 I2C bus signal
  This chapter specifies that an I2C bus connecting an FMC carrier
  and its FMC modules is mandatory. Consequently, it specifies the FMC
  signals that are reserved for that purpose.

  By this chapter, an FMC module must contain an EEPROM connected to that
  I2C bus. The purpose of this EEPROM is to store
  *hardware definition information* using the
  `Platform Management FRU Information Storage Definition V1.0`_

  Optionally, it can support the base IPMI commands defined in the
  *PICMG 2.6* specification.

  So, from a software point of view, we are interested in reading the FRU
  information that provides useful data to identify the FMC modules, and
  to do so at a standardized I2C address and EEPROM programming interface.

5.6 Geographical address
  This chapter describes how to address the different I2C devices hosted
  in the FMC mezzanines that live in a single FMC carrier. As the
  standard specifies up to four mezzanines per I2C bus, it enforces the
  convention that the two least significant bits of the I2C address
  identify the slot.
  For example, the mandatory I2C EEPROM must be addressable at the 7-bit
  address b10100XX, the suffix XX=00,01,10,11 determining the geographical
  addressing of the module in the carrier. Other I2C devices follow the same
  schema.


The fmc-bus Design
------------------

The Linux fmc-bus was designed in 2012 with the purpose of adding
generic support for the FMC modules that were under development at CERN
at that time.
Everything was targeted to work with Linux kernels 2.6.24 and later.

The idea behind the Linux fmc-bus subsystem is to enumerate the FMC modules
and to provide a driver for them using the Linux bus mechanism. With this idea
in mind, the Linux fmc-bus uses the information contained in the FMC module
EEPROM to do the match against the available fmc-bus drivers. Then, the fmc-
bus
drivers will use a set of functions from the FMC bus to make use of
the resources available on the FMC carrier (which is plugged on another Linux
sub-system, for example: PCI or VME).

Flawed conceptual assumptions in the fmc-bus
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The main wrong assumption in the Linux fmc-bus is the idea that drivers
are bound to FMC modules through the carrier FPGA: this is not true.
Behind this lies another wrong assumption: that FMC modules are in a
one-to-one relationship with the FPGA code: this is wrong. The actual
relationship is one-to-many: one FMC module can be driven by many FPGA
code designs, which might be wildly varying. The real behavior of a card
(FMC carrier + FMC module[s]) is determined by the FPGA code that has been
loaded on the FPGA.

A simple example will clarify the concept.
We can have an FMC module with a simple 5 digital I/O channel. We all know 
that
such module is versatile, so we can have FPGA code that implements: two I2C
masters, an SPI master, a GPIO interface, a TDC, custom logic. In all these
cases the FMC module is the same but the FPGA code that drives it is 
different,
as well as the Linux driver that should drive it.

So, the fmc-bus design is wrong in trying to match devices and drivers using
the FRU information from the FMC module EEPROM. Instead, the real match must
be done between the devices instantiated internally in the FPGA code and their
drivers.

Eradication Proposal
====================

The fmc-bus *today* and in its *current status* is not just inadequate: it has
too many overlaps with other Linux components (it was not the case back
in 2012). It seems appropriate to completely replace it by an FMC device 
class.
Here is how to do it and how existing drivers (not in Linux mainline) should
be migrated to it.

FMC Device Class
----------------
I propose to retain all the functionality of the fmc-bus that should
remain (see below) in a kernel module implementing an FMC device class
that registers the presence of individual FMC modules.

The new FMC device class must be limited to the real FMC business logic. This
means that existing Linux kernel interfaces will be reused, instead of
implementing dedicated interfaces as the fmc-bus does.
There are four overlaps between the Linux fmc-bus and other Linux
sub-systems/drivers: fpga-manager, i2c sub-system, eeprom drivers and
irq management.

FPGA Manager
  The Linux fmc-bus asks the FMC carrier driver to export the necessary
  operations to program the FMC carrier FPGA. Currently, this is handled
  by the Linux kernel FPGA manager subsystem.
  So, the FMC carrier driver should create a device instance for the FPGA
  manager.
I2C Master Driver
  The Linux fmc-bus current implementation asks the FMC carrier drivers to
  implement the I2C operations in order to access the EEPROM. In theory this
  is not really necessary; Linux provides a nice I2C sub-system for this
  purpose. Only the particular I2C master instance needs to be registered by
  the FMC carrier driver. A driver for that master has to be provided only if
  missing in the stock Linux kernel.
EEPROM Driver
  The Linux fmc-bus uses the I2C programming interface of an FMC module EEPROM
  to extract its contents, in particular the module identification for driver
  Again, this is rendered superfluous by the Linux kernel I2C EEPROM
  drivers. There is, however, a difficulty with the particular EEPROM
  to use: which one is it? `VITA-57.1`_ is unclear about this.
  rule 5.69 about what kind of EEPROM is mandatory:

      Rule 5.69: The IO mezzanine module shall provide an onboard EEPROM,
      which shall interface with the I2C bus signals.

      Rule 5.74: Data fields provided by the IPMI resource on the mezzanine
      module shall include the minimum records defined in the Platform
      Management FRU Information Storage Definition V1.0.

  FRU Information Storage Definition V1.0:

      are SEEPROMs that use a '24C02'-compatible interface, and SEEPROMs that
      are compatible with the Dallas Semiconductor DS1624 Temperature
      Sensor/SEEPROM interface.

  to support 24C02 EEPROMs. Support of other EEPROMs should not be
  excluded, though, as `VITA-57.1`_ is admittedly open to misinterpretaion
  on this point.
IRQ Controller
  The Linux fmc-bus asks the FMC carrier to implement the operations to
  request, free and acknowledge interrupts. This is necessary because
  FMC modules plugged into an FMC carrier share the unique interrupt
  line or vector of the latter. However, this function does not belong
  in the fmc-bus. As the obvious need for such logic suggests,
  the FMC carrier contains interrupt routing logic; thus, an IRQ
  controller is the proper way to handle this.
This approach will significantly reduce the FMC scope to its true business.
Most of the existent code will be re-used and the future FMC carrier drivers
need only to glue toghether the device instances required for them to run.

Another duty left to the FMC class is to export an interface to extract the
information from the FMC module EEPROM.

Platform Device For FPGA Internal Devices
-----------------------------------------
As stated before, there is no such thing as an "FMC module driver", nor
a "device driver for the FPGA code".
The FPGA code is typically made of N ip-cores; groups of ip-cores may need
different drivers.
The simplest case to imagine is an FMC carrier with one FPGA and 4 FMC slots.
Within the same FPGA code we have different ip-cores to drive potentially 4
different FMC modules.
So, the only way I see it possible is by using platform drivers for the
*FPGA internal devices*. The description of the internal devices is not within
the scope of the FMC software layer.

.. _`Platform Management FRU Information Storage Definition V1.0`: https://
www.intel.com/content/www/us/en/servers/ipmi/information-storage-definition-


