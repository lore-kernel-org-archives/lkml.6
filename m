Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeCEULN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:11:13 -0500
Received: from mail-db5eur01on0063.outbound.protection.outlook.com ([104.47.2.63]:37472
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753079AbeCEULJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:11:09 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Mon, 5 Mar 2018 13:10:53 -0700
From: Jason Gunthorpe <jgg@mellanox.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>, Oliver <oohall@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 07/10] nvme-pci: Use PCI p2pmem subsystem to manage
 the CMB
Message-ID: <20180305201053.GK11337@mellanox.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-8-logang@deltatee.com>
 <CAOSf1CEj1vmLLd27-642=XSnL9ODkpEC0qLHA2_W5_7rV5+4Pg@mail.gmail.com>
 <20180305160004.GA30975@localhost.localdomain>
 <36c78987-006a-a97f-1d18-b0a08cbea9d4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36c78987-006a-a97f-1d18-b0a08cbea9d4@grimberg.me>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [70.74.179.152]
X-ClientProxiedBy: HE1PR0202CA0019.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::29) To DB6PR0501MB2855.eurprd05.prod.outlook.com
 (2603:10a6:4:83::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d832b972-a6ff-4bf2-cf04-08d582d53922
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DB6PR0501MB2855;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2855;3:X8xOxZhXWKxZNKyG02v2IVWw/gRszYQFTUDTCeLjstWvUSgIrDqNFCF9c/de5pWlRAlgDjP2iIwsYh62cJH/FYVpYeVYE8PGY6HEg3y2XlSqdPvB4PT31fr2rP9doRXeXPLPEdH/HUvw2e7tYBkSXzhcbnzj2CopQO4G+J/3dwrW1I6tERBml1ylKb7/Iq8Wb8zrdxiLs2JxiLLLZxCDzMPf5K/c2YRynGtOKXTCIrpwW+p2PgloC6eqClsBHZbi;25:rBOtnZR3Uiafj1colt0XoFS/jLSGQvKCGiBtC/qed2bpbnjJ0KBEqrzPcs19P5+Ojz9Avn258JmAwaTSqUba/ezaxFD6fxggMK9ge1ZxAN4v4oRZmAjco7l4E/9jbtMji22hvnFrLyQ9wtAECx0x2UWlbtp5voLRIqZ/fC5/bkwp23NxbdqB2GVkeqNfrRw2cXHDDT0H3TzVw5tLHLnhmjbADm4ezyEjwpHIk9A7BA73pbkbyYe/380Vj9j+aFzpSDFc6plz2cMkBFADrwYbYIiQ0CdyxeE/RcU/UHff2YUiASoyTLlNOqNsUMDgJMJA8mXGwj+dr60pPIYDMY9fYg==;31:9tMI13dhjL+ZQml6KbVd8iVs62t30qYUvXRy9mBwL5rIhIfiG/UYU3pZOKhPe53arx95R3TVNJdjYq6awMD11EyZoQL40GPUZls7jE73rd49F+T5D8C7EenyBUygno2kmz9XXqqBR4ZCnpj7JCniPGr3Uy/I5AzcvI42dPYcAKztfI6tcMH2MQbb3l67YFP8En8CDxgak3seOH3SaBbi08WsBgPpOwWTFODFhbdDw3M=
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2855:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2855;20:6eoAB7d5+e9Xu4dGP8lwgTPgwiuVPg3kEy6IN7GcLSjkp3Wid8jyBQwdODvFSTgwu0UiraQDnixiuBofMtaMdDd7jGP32wn/dAwf1aWxTemXk2sPqjAX/x2NVlJgWQfWEnHtOX2W86FiW8TCKc3hCwXkryUYs+dhRktFPudVbNTun6XMkrUKsl20ctxjQPHGp2BqmnjLevGpSGAjIggtZMaJh/BTgESZGDqzvzoVXiONXsWM33j5VgPocuoQTUZ09cPGiaqCnQtESxZ0bmefRyqb+4+pfNyqnMAdwt/qrOUNgxTnrwtJeSLoxAltTMlJ8E3uhdjB7W6IZGRs5jogXvsX4yz0yYksAA6Aiipj7amuZcsMpRsPhOTxyBEZ6lEmRI9EmKzGeU+ISQjsxaj9zyg4fYqlQNCY9oBBWhIlxEJ9kvlIkc14fxeSpu58UvsBqFUY8VnVuVhfzvDFxm3Ki78LC1F6PL62RSQXbNVI5ctGVn1khGN0vS8kBQmhYxyC;4:ITasHg9DwgH3syhtiV/6r7NkC6FmLSTrTLdnOkkaVpsmvR6nz1vEhP8+Ui3N7wTcMQJA/FPjhAU0o+lII5o4EohuqPTK07RXtaJnd1KGCg3Caq7wVBF/9mzVb/Xiea9+N/ogCInzEpLjM14qnqRcA/mT1/36ZuaD54A9Uy9Vja8H6N5hc3+8R1WPtZ9XYmYdP2dFcLUHHTNe9oO4yy2JG40QaWGxlW00Jz1pUAKhc6ubLZBsYsZ9ujGeALYQCSjM1Ewjxh1fpneAh/r2jCkHDg==
X-Microsoft-Antispam-PRVS: <DB6PR0501MB28557049866AB9E3BBA2FE69CFDA0@DB6PR0501MB2855.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DB6PR0501MB2855;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2855;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(346002)(376002)(39860400002)(366004)(189003)(199004)(47776003)(69596002)(2906002)(8936002)(66066001)(4326008)(81166006)(46656002)(39060400002)(59450400001)(186003)(5660300001)(26005)(23726003)(81156014)(6116002)(122856001)(386003)(1076002)(93886005)(105586002)(68736007)(229853002)(3846002)(7416002)(7736002)(86362001)(52116002)(97736004)(8676002)(16586007)(106356001)(36756003)(9746002)(6246003)(6916009)(50466002)(57986006)(83796002)(33656002)(478600001)(2950100002)(9786002)(54906003)(53936002)(316002)(76176011)(58126008)(305945005)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2855;H:mlx.ziepe.ca;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0501MB2855;23:9/bqxGMU/JZTqb8cgRV5YlY5fbogWfvqdHYT3n3?=
 =?us-ascii?Q?cPWcE/4LWx8V9t8bpb13AO9uJcGyBvYPk5nZEAeIn7IgnLIa9Ktcov+oC/W6?=
 =?us-ascii?Q?XU8gvOyH0osjx0ompTR2z1acXHZ4NXSBKQ73WTt5ABhcYSjuZC43FIisdUZy?=
 =?us-ascii?Q?RBIDcsRxYdHU6aasa1r4Xeq7+lIslES+H1Eqo/0WRFj3srz9qMeUhdb64kYg?=
 =?us-ascii?Q?tLawDTk27G/wE3szv3DadbCjbjZ1DieE0t+++SILArdHvGsXGwQmJGtf9Srb?=
 =?us-ascii?Q?bOcJ2Wxud0xM48P8d3p19mmzeZBJQXCCr2g4Wva8aP/285X5nzn9M7VZx4Yt?=
 =?us-ascii?Q?Wxb5Simxm5BI1JIQuBWftTI4rheEQazoGH8ccI/4bUT4sZ6B+/FTYsPz3Ey1?=
 =?us-ascii?Q?XkFL9sZVDhHY1wU3ysiY5XhtX7Y7IPEC3gO3nOsYgiyuGi5tUaYRSp7eaWqK?=
 =?us-ascii?Q?vdFYqapjKDQzYIy5C17+L0kA/Cdd94CUHvSyDXYE5IHyAmSdqhF4cO8shhr8?=
 =?us-ascii?Q?K9PzETFQEI06j3jeffeLTgRrDN6E/6F7fmu0sQMMDOrukDAsxAuZtpityukv?=
 =?us-ascii?Q?uBZFOB2oUAVPs8hTgMI+5zyqcuBmV8d51nDDYtRt1+x0L/vLpLCEXhCV0cQo?=
 =?us-ascii?Q?IcvEbPIw6JyU6pBr8OYGtEBJ27/DWLLHuooGS0Ni6SnZEbCRMMOEESAkaxy5?=
 =?us-ascii?Q?67CYs/SloF1CWzpPGWu42IGCW52me1jziUJX4Nb0xnicCWbptV8WSa4j/uvu?=
 =?us-ascii?Q?+yC2F358iY/QqLNXOeH0jPiT7Co8XF23x/KRl6B3l5vbZHDL+aF5wvpIMvub?=
 =?us-ascii?Q?HMDMZX2X2qa235CV4bgjZ5B1Idkelz2+lTpMgokcer9h+lIjQ9t1/hBDHqhl?=
 =?us-ascii?Q?uQOUEhQGh+yPNskpDdj8SmXWdCw6f4fuMnUjf3U45eQlVuhwCwvXoXMTF4P+?=
 =?us-ascii?Q?1WiLjnchEgvy1UW4IafMMtWlOD74ucHaFqkzs9hzF590KJ4u2QxQaoxMi/hT?=
 =?us-ascii?Q?NEVFopufGPXGU8+l2LkSoMEMzdzZCnc/KnKfW1v/S/CqhdmvCAPLg85V+NeV?=
 =?us-ascii?Q?hxKLGKYHE+OtxNx33XqpjmCfj8PRUeX6KxFDd0wfLXPe4MnPe8OmVjzOFVb2?=
 =?us-ascii?Q?1snmxvqqviOO2ZEJXtYlHgDk7rwwGUn1TR+1AZWj1NRpGsnkjQuRn31lJNeL?=
 =?us-ascii?Q?DxtH6Ju1Fr3+nxgXE9zNV0c/B1J4lqmN0rnrgNEMcWS8d/KvBX7+KKOQ0/jt?=
 =?us-ascii?Q?09VM8opPkZG456vwufqzD98/IO/0nRRAPvqnksoMpEDNMcs2YOFbm5O1vpsJ?=
 =?us-ascii?Q?kX7stGs5tPpPRAusxy8q/X1/TYu87XdIZY3WsXHGm24Un5mL8vvXNF+PQfJV?=
 =?us-ascii?Q?wi1mVoK3WR73dEqyPGIhruHh7IAo=3D?=
X-Microsoft-Antispam-Message-Info: 7upJSoLeQV8V1XKEryK/U/3mszNG505D2WlEpONGd2jLDyeUFrCeAV3Fq6TSPShWLyY1VXvtlswgs56MmOi7pYoso+FiNRNuzMWAX9tU3uZKHrGKqpCAdxtQaVg5UskYOrOrJ9envDASG3JpsRkw4FrNpuqXOyAQL+dh1AmEtYYzLVoukCG7LH7vFBLNcdVg
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2855;6:eugRqfeNg9nqN1JwJEj7wNEZhtEkqPsWLbaKAamoYneg2qnp4TxFEUjV5dgOW/iuDOUtW/6JbMEdTxQ0wukYIXJpNrVATcWsSYpJcP1iOJxqB0fr/xy8pablw+daYczEXlArZim3ef6D72D/MrO8TvfNUR/GlTS64YKKuljXdyGPJpXiBiVawLB9fVLoscobIXc6x+X1uMmr2pjiZU0jWY/peyCwtWE8C/sjereiGROI3T5x6Q4hraWTG/5lmU0/CmPKniRGf3c8bwnrwbhLCYAAieTfSYgAX+MbpvBLybTBXJeLCXAAozK/NLnXqArO5Abydob5BT1wetAZA5c+W561z5AewwP6BmoC8dD9OVk=;5:12p2dYA+I6ipi4QUc1Q4c16VOoCoe6OwYSNsbsfNE2rEXwHdl5uGX8Snmp/lQ0IG6kbxT45Cxdy7LhS7zqdWPMaThZ1aLHw4OSeNqEA7Dxf3cnecmvoGOT4J0zqtJHUwmq45/Pfeb1w6GLusOZj9ZMlbuExM0CMUsFWP7UpeBO8=;24:L4BMpK2LJLX/1RcmJW+5hiZpmcQtN0ol9mU7KKYIkCOup2CgzsqqTbGj2wyFtJLV6q3oVJi1kG0DT6+wXdGR9mbYs4h0Ga9XwdMiwFjE+xg=;7:SL4cj82irfmfTzzm3inpJgGFNH5JfvLh79wTSVa+V+RCLXTD7R8zztgaTmnWrwjUclyZabkH3j0/wecFqYCWuMdFSgQSquddqeHfxWnlirUvkzYD2JbDFzJAjqBbBlhBd51M4z2IHpCE3rhXBaBJF8Uq3oit8hzQOdRy+bfUr/jo6dq+gRjcscQCzM59R0GRVmafV1I/x6h+7qm5uYhZDare+Pd+4xEavVzmRnf7cQYE5o/cYzoubb4jaCvoHoro
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 20:11:03.8520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d832b972-a6ff-4bf2-cf04-08d582d53922
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2855
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 09:57:27PM +0200, Sagi Grimberg wrote:

> Keith, while we're on this, regardless of cmb, is SQE memcopy and DB update
> ordering always guaranteed?
> 
> If you look at mlx4 (rdma device driver) that works exactly the same as
> nvme you will find:
> --
>                 qp->sq.head += nreq;
> 
>                 /*
>                  * Make sure that descriptors are written before
>                  * doorbell record.
>                  */
>                 wmb();
> 
>                 writel(qp->doorbell_qpn,
>                        to_mdev(ibqp->device)->uar_map + MLX4_SEND_DOORBELL);
> 
>                 /*
>                  * Make sure doorbells don't leak out of SQ spinlock
>                  * and reach the HCA out of order.
>                  */
>                 mmiowb();
> --
> 
> That seems to explicitly make sure to place a barrier before updating
> the doorbell. So as I see it, either ordering is guaranteed and the
> above code is redundant, or nvme needs to do the same.

A wmb() is always required before operations that can trigger DMA.

The reason ARM has a barrier in writel() is not to make it ordered
with respect to CPU stores to cachable memory, but to make it ordered
with respect to *other* writels.

Eg Linux defines this:

writel(A, mem);
writel(B, mem);

To always produce two TLPs on PCI-E when mem is UC BAR memory.

And ARM cannot guarentee that without the extra barrier.

So now we see stuff like this:

writel_relaxed(A, mem);
writel_relaxed(B, mem+4);

Which says the TLPs to A and B can be issued in any order..

So when reading the above mlx code, we see the first wmb() being used
to ensure that CPU stores to cachable memory are visible to the DMA
triggered by the doorbell ring.

The mmiowb() is used to ensure that DB writes are not combined and not
issued in any order other than implied by the lock that encloses the
whole thing. This is needed because uar_map is WC memory.

We don't have ordering with respect to two writel's here, so if ARM
performance was a concern the writel could be switched to
writel_relaxed().

Presumably nvme has similar requirments, although I guess the DB
register is mapped UC not WC?

Jason
