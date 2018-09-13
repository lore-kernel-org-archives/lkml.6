Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C431FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A42F20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A42F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeIMPmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:42:19 -0400
Received: from mail-eopbgr700073.outbound.protection.outlook.com ([40.107.70.73]:62130
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726854AbeIMPmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHCODOE/TUIdmetnuZZoOdWNPlzBQHtUo60U/8iTW/0=;
 b=GyTJj8sjpRLv2hbf+yWGUHhB8eChF8KCp99mZFoFg+mre7kMK8wlQ1hqlI+cxjnGIvBsMQGEPH1ZAXA9Pwr1vaDBxGO5lg5FgltH/wl1QhMmh5tdN6bMs1rQeFWePZJFDVOyKV+0gjfTbXsWx7kqdyZN+tiozGryfnCkwqpByXQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1569.namprd03.prod.outlook.com (2a01:111:e400:52a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.17; Thu, 13 Sep
 2018 10:33:22 +0000
Date:   Thu, 13 Sep 2018 18:29:54 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] PCI: dwc: fix scheduling while atomic issues
Message-ID: <20180913182926.365d155b@xhacker.debian>
In-Reply-To: <20180913091534.GB32721@e107981-ln.cambridge.arm.com>
References: <20180829110408.556c3622@xhacker.debian>
        <20180910165722.38218779@xhacker.debian>
        <20180913091534.GB32721@e107981-ln.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYXPR01CA0064.jpnprd01.prod.outlook.com
 (2603:1096:403:a::34) To BLUPR0301MB1569.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09b11934-0a8e-4687-f54b-08d6196455af
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1569;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;3:5PGBhS+CWWl4/SAogdC+MIInzELuG/93gvPSvaiQZWyFvd/LVrQYdQTNtlxjuQG4IMRfk4jNUp0AFoZdjkVsIKH9AcXLGTOmmhU4Jz8dOaCD3vJqB9OhFFH0LoV2Gwzjofc2k4Rfyk0f2don6nnkru3itxFVppVqD5bgc60MOpJ9S+v7X+qxk73OAJjhi5rLXddo2jwRQywsQoaNNVniW0OcRsgFHYRqmmao9/5P/kpjHSidTAgMwan9VkjSnn8F;25:IAi2zXzYDSgzVM6LxYLAH6OTdGsuRBXGrTIxXTCO3K6e3s9CIYNFMbJ+IqTYVOGuERTRQHkXvJ6ri1lNEogtD5rB9+M8KxRmc2ju6b0OAjhB1EEGas7mNBdrHAdyNUS9DN6tOasEqjV7FS6065fB1zlzlwfzC3WGQSbpa85IuetylsXNAauCRfqm1N1gPBH53zoQvuq24SEKT9ad1GtQq97WgBEV94gg9JnekDXkoTKL4jEWZYXIl77SWxfdNIpdl0K04pL+h8hlOuYr5YQtCqvAQDg+MSVqDqlMb86b9NX81qdikEACYfK5Ax5ZpjLY0pwMAHEgUoX7eRlxEptkWh7YG4uwMyIlGxBU4k/JPcE=;31:c4jCi+qMHDgNj8mCPk03fO85d0GR6+a/zniqu7uVsEmz5qwaaQ3XztL8yShuh/PZakuxfSirS6O6OTRHcGX+1wjl2HOlYzsycMSjiysiRgYzKgIlm+OYgXTTRMyC6kWeWJWsFhAuV5LJIfLYQGrW7Mv7A6CsbX6djddncYEcBiNeaRZBXRAQy0zfg9heXDdtR3GEGhk7F/Pi4aDIV7n4rS+IykKuIR4Y+tvmfiVYmxI=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1569:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;20:e/2vMQjHt628I0NzsdyuR3dGszsbScwG3EcYHJJ8bsPoAOQ7quF+AzAVJdpetS6eQjdo+xu2wKzndNuT1iqIvE5pweygD34G4LuiFd81amAw1XIIIrLOgyV9jNSguMa5dXZgbLzM009bdpypxnYs7CVslIdRtD8Zmqbe6+iZKpUjHw8/T81izn5be67DjdHzpRqDPcGY0jPH30s4de5EnugWohasKHwTO6HyVOHbqi3KawgJvLZnQnimZ6TxbImbq5Eb06NLB1UFTWge9AxcIxOxTvsak/I9JQUtR67QkGXUz//TpXsmupl0v85KXMsxSN/bJfrLApZWjb7nmmFv3VVlE+RKBc5XL4qJDfhMJtl1hLrRhx70hYEhts7/2NPJyFXGD8YE3JgWH1mrTAbDJsZuWATl917bsStabjYHcB2d3h7rS/HSrBhCFYvLg5VV5vq9Ghp2XkKEDSFtOFrre896Lj+0XOc2DIz9tchyrmW8C7NPkkt60gWRgDecnmiS;4:YqQsv2ky+F5bnEzaH2aCHtr1nDPr/nlw2+aQoSLUigXYsj9AeIDqTOOBhInyyAG/a6JU3jyZylEvsL685ddkAd9S7NYPr8RWwV83sFm+ob1sG5RI6Zya8GkIkgXBAwxCM6QHLOiRqQUZlSnOS+vZSDzoXfBRJmRqg55VQZVBipHqMrIRLZOXpB8K9law2XkfUZ8B1hPh4q2PGQF8lePjkwiyrJd5FCAXewyl7LrV3K2uSrwz4nGbD8mD5D8WdR/pnF3W/vvesNBoAlBzfd2BZQ==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB1569303F620CFAE2FA34CCC5ED1A0@BLUPR0301MB1569.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:BLUPR0301MB1569;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1569;
X-Forefront-PRVS: 07943272E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(396003)(136003)(366004)(376002)(199004)(189003)(53754006)(81166006)(8676002)(81156014)(33896004)(76176011)(50226002)(5660300001)(229853002)(316002)(54906003)(72206003)(1076002)(6666003)(52116002)(7696005)(8936002)(6916009)(97736004)(23726003)(3846002)(6116002)(6246003)(478600001)(446003)(39060400002)(11346002)(68736007)(2906002)(305945005)(186003)(16526019)(25786009)(26005)(7736002)(4326008)(47776003)(50466002)(105586002)(230700001)(476003)(956004)(486006)(106356001)(55016002)(53936002)(9686003)(86362001)(66066001)(386003)(6506007)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1569;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1569;23:oM/rFOgpmjdByMb0H5aekxwQwnm41ipo29xwJpt?=
 =?us-ascii?Q?fa/tpVorujqw1m7/ykxzJ5ieAZwC90qgl7erD6HLDzEOTSAipgtacdZZGA27?=
 =?us-ascii?Q?ZyMiRpZk2XWfmhxar2h/rwfGGmOskVqZfxgnPei+h8NlGsH3FjXJWjvSfCU5?=
 =?us-ascii?Q?Xdpavd41ELadhnZyIL3yzH2Qpa4DIcxl47Kzyk1ryhuNcUhVJnbCML/gmr0c?=
 =?us-ascii?Q?RhWDLssdHLDqBBu+InUDrFzlmqdXRXyTciVGaNVJkiS6YTtQsoYQh+4gnppN?=
 =?us-ascii?Q?GbTXgmzjoxQGee4g3tf2fwdOej/7srlKoCUawH7n3TP4x/0IAP4fpOxKp1zZ?=
 =?us-ascii?Q?1vVIvu9q0nBjo6ZKrY5BFFsmVYT83wEe0ycmauOvecmxXlV4wuz8E0Kec633?=
 =?us-ascii?Q?n8/fWWnUSpt78fpDAecZn295SVmJIwdtLbGqb/Eg/83SHpc6UiYrdFI7k6Jg?=
 =?us-ascii?Q?AHQTExluBQiJA/Bx6mTIqVonViKPpguz1prfIevjS2rq1NTt6Fz7/34fqxPh?=
 =?us-ascii?Q?N+gArU7u3OdnTTbBQLv0BXZyKMPHmarTD8JJQlo5dhPORJ9PV/Sno4zdachn?=
 =?us-ascii?Q?7Tn/34HQfZO5X0mfZlmdnu1KNAwb0Bp57ltlYSlmPhd0418W/iL8BjQpMyDi?=
 =?us-ascii?Q?552iUt1aSJhjmP/wdu4NYBEvRJkn5J5OzfLoh+rHMe4bK1K6yaLoc/4GwtiW?=
 =?us-ascii?Q?WBSJPyG3BSKwqAhyqABSjD4hXbSd0UvssTYKHHmLRNX+8qQ/+I6+tnHIauVh?=
 =?us-ascii?Q?BdsHTWrRgAbjw3qpWoJE1SKj97eUQCMdwoqqQPILvGZvpSxot4ZbMA+Iq92z?=
 =?us-ascii?Q?o1YmJ0bIXqg9ce7xDMZPql+OyskMdyu8spX+dUKmT6NiSjzZ1bvBp08hga1x?=
 =?us-ascii?Q?FdmvwdqAcpP0hJjExjLEvdR81DZNsRyO/nYASXBKEEk2AboRnU6PpQoj5Kvi?=
 =?us-ascii?Q?F3dkP02LRmLz4MT1QUQUqJoWtyElSveGorEzLwSDm8AOMMtow5bYd7ZgeLXO?=
 =?us-ascii?Q?Hwvjv/5AstiOkJmD5V8ZEs3JxUx2Kr715SWqDnV4SbYfz/Lw3QzpZ/GeNSUb?=
 =?us-ascii?Q?xvSQLBp69W/nvuecyppif0YDTf1MiGuPsVK39Bn6QZ1R57saCPwcBYb4z3PK?=
 =?us-ascii?Q?Df4FluVt/THKQD5Nlwoup8SDuzEQ6NyKd1uo8ubzZhbn17qYkDRq/w3+LsUg?=
 =?us-ascii?Q?FrS7ZUMpR5OFpwj3O5l6/rRnOTYESEu1ddrqiEA0RpMlL0tnbjdlajmQ4bwU?=
 =?us-ascii?Q?HjSwRJz3NUcGZAGesddf8WIoop3JLCzQ6WJ88z9AasVQEn96FQ7CKbT+EgzF?=
 =?us-ascii?Q?wylI9nv03wb9bpVKlAie7ymfhcK/rDiwgVIHdXJDiJ2/c?=
X-Microsoft-Antispam-Message-Info: ogpgfQjiWrO3M9SK4iyeGQGgTQrM4UPJcj/ZFLzGNRRBrffUj4wgP2A8Ah6lgDZA3lQQQXL/TZcCuWGSrukFNIpeknI2wF4TWfaY40r2Gp+gqzEQRf/w7c0WwljY4v6PtG7yWX56OzBd7BCiVTqcrtWeO9zKhWAVa2DVUqYWp/Y428cK9oJsWidsA1beS0LS1+WmyoQ0zhw8Z2bhOrzTkgki0EvrI+joCHdcOKh+suaZHqJGGikBEjEjQ6rf8OUZtvmdF7HMdlus4ladP9s24rJVRZfAZq/n520Vcq/yK0QGqlUFmLI760R5bRGYxbzJlpv8uhEbYgH87KXR61r9hion7peTVTXo+aio8V7LRAU=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;6:ePs7fvB87pVnecavAaM5/s/fJIm9J36VWHFC+oY96Tk8/U5NsxLjFtVuMTqFEzcxSx81JA1GySTdZcv6TH7hxex2e+jiquDcS6k34PR7hHrxmmGN+3e4Kf6RhLkvHLyVbZrqKObEn+uFzdX35uU8Tk6OY6HVTdZeVgQlc+BBabjTnsLY659u067glK/N3531t7qZz08trs9RtCNLNQsXagiUXeQldefPGUi0x8p6tyg7LwrM2YXN2w3BYBdr+3JWyLQZ9VNiWK99Z73jJF7RBvrlI5wT0f+tRVZqUsWeXxIKp/bTWf4EG+W7I53TDZrXxA6e/EarCgHfYNxD46gUYxLv4jYBeTDgzcCPDgGWfT0vm8p6hRrA8v2RN6kMgJrucMA0OvN8Dozh2aiNcdEQXygi5y36cE2Oy1lBMOBX5IY0Os63HEeu56fJdbFKMHYpWAaOmBzN6W9cwXCDs2L3SA==;5:PWFrSTSvVItspc9kWGmpQ5lLfVmjuFlHMN596LDqWC8UNqM2cCt9+JNB/fDkg0eveapLHiUm5ROKaJb6yQl3QC/VFUj23qPD2Xh/NgnuYSSQs/2vdI0rEKi1lDz4tV1jPEsVfcdyGRN6zzo1kEzCDDTExFPnat8WdC+p0qWt/Iw=;7:EbMxj8/znM1lnMhuGjr5glVH3XxjYchPMcz5mze6SMFUwN5Ii76RP130r4rvMcPhbq2HyZbfFHZZZtwJGYHhoZghkg7MsnXbhnw621qUn8i+MRDUdruui/kzrDrxgrDvDd0T5J4MdI5ClD6DsmXNE+WYeBQUW9UoqLb0mEvipDS3JR5C7cpwu1Wzyz0Kr1r0guqZLkrF91+qPMf2E7P4WzLfP271HAMo8Tt+IcuA9OTfZJZ+7JhVDUSFq5aqCOEf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2018 10:33:22.3584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b11934-0a8e-4687-f54b-08d6196455af
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

On Thu, 13 Sep 2018 10:15:34 +0100 Lorenzo Pieralisi wrote:

> On Mon, Sep 10, 2018 at 04:57:22PM +0800, Jisheng Zhang wrote:
> > Hi all,
> > 
> > On Wed, 29 Aug 2018 11:04:08 +0800 Jisheng Zhang wrote:
> >   
> > > When programming inbound/outbound atu, we call usleep_range() after
> > > each checking PCIE_ATU_ENABLE bit. Unfortunately, the atu programming
> > > can be called in atomic context:
> > > 
> > > inbound atu programming could be called through
> > > pci_epc_write_header()  
> > >   =>dw_pcie_ep_write_header()
> > >     =>dw_pcie_prog_inbound_atu()    
> > > 
> > > outbound atu programming could be called through
> > > pci_bus_read_config_dword()  
> > >   =>dw_pcie_rd_conf()
> > >     =>dw_pcie_prog_outbound_atu()    
> > > 
> > > Fix this issue by calling mdelay() instead.  
> > 
> > Any comments about this patch?
> > 
> > Thanks,
> > Jisheng
> >   
> > > 
> > > Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> > > Fixes: d8bbeb39fbf3 ("PCI: designware: Wait for iATU enable")  
> 
> Can you split it into two patches and repost it please ? It will make
> everyone's life easier to backport it if there is need, I will apply
> then.

IIUC, the purpose of this split is to make the backport to stable easier. If
so, I realise that the Fixes tags were not enough, we missed:

Fixes: edd45e396829 ("PCI: dwc: designware: Move _unroll configurations to a
separate function")

I'm not sure how to handle this case. From another side, the issue to be
fixed is the same: call sleep in atomic context in the same driver, is it
better to use one patch?

As for stable tree, I could send out separate patches instead. What do you
think?

Thanks,
Jisheng
