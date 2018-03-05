Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932451AbeCEUud (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:50:33 -0500
Received: from mail-db5eur01on0080.outbound.protection.outlook.com ([104.47.2.80]:32236
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752040AbeCEUu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:50:29 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Mon, 5 Mar 2018 13:50:15 -0700
From: Jason Gunthorpe <jgg@mellanox.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Oliver <oohall@gmail.com>,
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
Message-ID: <20180305205015.GT11337@mellanox.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-8-logang@deltatee.com>
 <CAOSf1CEj1vmLLd27-642=XSnL9ODkpEC0qLHA2_W5_7rV5+4Pg@mail.gmail.com>
 <20180305160004.GA30975@localhost.localdomain>
 <36c78987-006a-a97f-1d18-b0a08cbea9d4@grimberg.me>
 <20180305201053.GK11337@mellanox.com>
 <20180305204212.GD30975@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305204212.GD30975@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [70.74.179.152]
X-ClientProxiedBy: HE1PR06CA0139.eurprd06.prod.outlook.com
 (2603:10a6:7:16::26) To DB6PR0501MB2854.eurprd05.prod.outlook.com
 (2603:10a6:4:83::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5802d96b-7781-4568-d4ad-08d582dab852
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DB6PR0501MB2854;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2854;3:uJiBKSL9VER5v73AfJf6p17tgZCw7Bkuyg/43OyYTnjbnSYUjnBzWVtgFVbaqfb4zs+WSOGnx9vkR3TM47TyvIQRtMj/3k+16q5F0ODkv9aYsosBKEPkPCyRSth72CwRsxpGCd3Yg8xKTGZywkf6p51GgRcIT0gOfxy6MXCy4tficFaFTkJ7rz94LrNetW6IO2nSd5vtvUt5BnFh3CnCTVkfhkeAJ7Hl2bP8TrOdtPJGwS6zWWg/H114Vis0vX0w;25:85vam3P9uEJ/ej9gTgv7QVIm9T0BqmgiOjsRXB18kJgP+b4/jNgvexmpfoEtaZ8Hsr7zlWG2sTJTQHv/plEgfmj3M9LDXL4Li/EEG7lmt0nlHjYHV8fLLtV04wZnuHglrigwHzF5A/ZgfeSrfX4pYVBHiBCm2RYtQqga7gZQ6mVpdcfV+CPspSyaeYZZts6a4o44ZxEtBTW4Hbx52ZbMqLl9TFEMHwzDdgvdHrkd/m9VPvm8pj2iMxYH5SRhF+0qyZAmvYWKHRCfGBH8pXUfAb28gr9525TN2h/mVimYkVHfcbU9xGt/amOhbpn1+AgeZttjETLzIU5pVrPedg+ieQ==;31:8v7ccR5++awPL/RdFTCi0b6tFOI4BI0iJ2SNZUo5ZROGHzz4Rk4+WhNRAKhHySzhBv883OSW9wF/uTSHkjPe5jY4GimVbS1QI0cn6+CmPSegLoZoZnHeJlm4rPuWqm2aErqbp5MuIXOuXyIJkiuTfjqly87YV8i9V+OnXePCiTtxhrxC4qebzewiK85LpM5aG6NheLuP1G6aGJb88uZcZ+LOJ1CxYD6acy0XaTJLZ4A=
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2854:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2854;20:SD3adGDkrZIYHInPzbv5P5b2mksaLcZ8zR6qbxU0JnV0xzsxWksOiwFrZBLkIQ3ws4QzP6Pt1YJ2aGj40JeGteZOZr1lBiVsYcYVXY8CS5SpMqMy28CkWW1NWsn4EQL2phZ+HiCcLlxmd5DV4qk6zucRbVtHyhCy69uZel7y0B6t+35ikOoYVTNaUpZBZcGAkcLDc9Z6NvPnUC88CpVRnz3lwBrO5FcHkDAf5VSOg4hvjHFzPkHcFNQFnMwiD9IQ/Nozm0Kq4r2xvha5cx4ECUyCynJGBSR/cfxMl+Y8fTItGnaHsT8zKeFDN4NvFqfliB2hdfpHGo4zE94dGkPiHTpTWMorsHUES5ouU2STwSEjizgjRXBOidrkiXcqffTY66tiPFn5HjwtFhQiFcFv5OOsG9fWjHLIrk3QIDKUwlTNr+Rmchn1d1ZscLyWCkA34BUtOm4FzP2/zv1m35hA1XITU37D2Aomely41f2IRbmXpnIVmJIsbS/RLBm/OUFN;4:aUynAYiExpiGkRRWSd25pcpDvxAFNvG/bDT60nt1dRjtDCsVMNARCv4BQyak3F4HlGkZ1DiGEdiY7G8xj472uV5FQVc3nJ6J0Wr/Q00Cd1/VKKKC/kXOqt7UXzgGLnK3fDVyTOstZ+Ny9C5AxLWMnn5FWIrjNC2UPDmV/43qqrmNWKV8wo/OFMMm/xL19WjbogOG1BLvulS+xxuoziWoRLAe4FEGMOhlc0Sex07hpVBEEH2jXvPEoS7g4uGVlws8i1cku+ZzuSOqcNqOrhpebw==
X-Microsoft-Antispam-PRVS: <DB6PR0501MB2854141D6DDF837AE72B3A72CFDA0@DB6PR0501MB2854.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041288)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR0501MB2854;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2854;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(376002)(346002)(366004)(189003)(199004)(6916009)(26005)(7736002)(6246003)(2906002)(9786002)(186003)(9746002)(83796002)(46656002)(66066001)(52116002)(316002)(58126008)(305945005)(86362001)(8936002)(7416002)(106356001)(16586007)(2950100002)(54906003)(8676002)(3846002)(6116002)(69596002)(386003)(39060400002)(1076002)(50466002)(23726003)(81166006)(4326008)(229853002)(33656002)(122856001)(97736004)(68736007)(93886005)(105586002)(53936002)(76176011)(5660300001)(47776003)(36756003)(57986006)(81156014)(478600001)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2854;H:mlx.ziepe.ca;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0501MB2854;23:6b468pxLAwxDwWeGOiN2xLbQ2ppl/nUYvDxU5uD?=
 =?us-ascii?Q?8/nyqcwL2Mqp+UYN9NUKQ5bN0vAfzuYN3XiNuN1+ODkw5XJ0Sfz57nz0o7aS?=
 =?us-ascii?Q?s2StuWko/XvpoBKgHvl/M28CP7/F0Y3Yjdh0Nhont0l6vKjc/LS1KzaIeVAa?=
 =?us-ascii?Q?yHJWNzkXiO2B7wISQH3z0gnHBYHc//4zC+ZBK2sFVOaAzQtsoD5Pw0Xg3rYv?=
 =?us-ascii?Q?QiDA8kWxIIpLJw9OVFIoXoHhgCerYyl3CulfWT1LKV2r56amHMPYJKafp2ie?=
 =?us-ascii?Q?XCDWWT187Ahzw76qnU3a8Wly5Cro/Kmfu5Gt14pse5Bo5IHCuvK5cf9y//Mk?=
 =?us-ascii?Q?A7Eky2qOKKgSETnnr+KNyexEQuMBXCQv+FOW9u/2tnBFhOkJTOmL6GqC4k/g?=
 =?us-ascii?Q?BcMXdwVgbcy+6FxYKzSyKw0JjbP/fjUlFwCY7ZBIOWtc9+8xWbGN8bUXoVsW?=
 =?us-ascii?Q?yZ7fQ5qcmfJfjBmQDjOLM+LuE5jE24i6JRBQdp2EkcsLMI1VV3PP5ns6sWom?=
 =?us-ascii?Q?+7xcwmeUbuY83aQ+sbYq3kLNO9CksETU0jycMhuSDiJhLZ3inrdRtSvb9KAy?=
 =?us-ascii?Q?NzPrcwCuT1r5Ws6NNyN8NY9o+d1698YZSGTRXeXqxZAj69wnnp2gT7Kb0fzp?=
 =?us-ascii?Q?0Z4bS8ieo5rMdtYYXLXonKWUlm6jeuXPe00RLb76o0Ok7nKU1c7quI1Auc6p?=
 =?us-ascii?Q?X7zzrYC0xCXmqk3l431PaION7qHLP7jrVGy2p4Ve/7DDVV+J6kPvTkj6m1mj?=
 =?us-ascii?Q?ss0Q2Sa6hImAFP456siQfikxQLT6Oza6MvntcUEnIbdVA+MZ5P9gXSdvFnkB?=
 =?us-ascii?Q?aGUQ1bc8y9BIDjqpkxrZKn8WSiarAH+96xUFTaKEEKHfhd22BN35j72C/teL?=
 =?us-ascii?Q?ovpbMXQyLMsZVDtd5lHYaY7eFMUOndyppHM8Dd2I3hWwVSq9mEKBAIWl813s?=
 =?us-ascii?Q?BsTHINJU83tomfzYu/DJZCEwLOHRKPw4axb03Pa2y1xCg2g4ergFOsYPBrg3?=
 =?us-ascii?Q?JqdAPNdIoCllw4dgy6HGwmY5cXgTc7mWsouqV/0SCJKm2okDsX/Ah5lBwAd1?=
 =?us-ascii?Q?Ylzj+dTqRT3hG+AyVUwSUMrn2Muvrd5dZ03hMFe4z/kAHCc5t28O9XHesm66?=
 =?us-ascii?Q?fHE1H5Jv2jF0JovuPty8tNY+OTQ3tSgR962gh+9eEFwCXvFQLlih8+kcSNal?=
 =?us-ascii?Q?bDwXSnze1/7jbwtpoLaLExwhx8e/P5uP4N9suxc+s0PnRUsTVUON7WI9KPc6?=
 =?us-ascii?Q?eGlOV1x0DOwOMVKN/CXl4Dj+ZCGMJSN99i53yM/hm0qM+/yRK2KXB6L3Vy/U?=
 =?us-ascii?Q?yEemwBgy3suCJOXI0E2fipQIuY2BhWGr+Bi5ogakA+EK17SR9rZLr83U0rxS?=
 =?us-ascii?Q?643WqLQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: W1wgmrM1RHTxCCp9Aessek4BtTDRQ7TkhQZEpKC+Un7rv549jcWVJjFg3TPzWv3wnOKWaDjoWPw1ka+nMFR7D9WCWJ6OZCgi+9rf8j0UgPrZMVTwyt+yUKs6vMUjopSgcBUt+yNI07e2iNJ6BE7oNSzWMnzJEVkUC65v8FETHuueTZp00e7iFLCDjnHZ2VJv
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2854;6:OEhKdhgTFwGaT+PqUMrMpQpcDBGpuA1idz8REA/+ky0Ktna6TE228Qk4Z8AT31683pS88HA1t57bK4qkVwCG6X2YB/s5KimQZYd0OOoizfF3MPu9Jge5lWjMGjn3B1LPIZBclOthZ6WChXNUvzQy1veEPKcXkGXuQq+9tizZYOcexqC/grroTzN3Y84jV2mimNFzLwWMYJ0dfRixS6KX/CCc1WA2WNPMzMVhx9rIiz9ZlTn4Fh1yNqSv9bXNXpfuNQ/wbilXGDyMYxMSlJDE1JisgVv4ZA6FM77fP5xBSr0eMBYvXPcmlXIiOovbepgzCQGxpZ7DholdyfLw18PJ7bagRYeBBIUqsDTDTIUk6Rg=;5:SXcts4bFH4or3RFeaSAxxq08BWC9kD5wpxwXF8VTKAUQwwc+um8IxmVEkFUxVvFhuGqNFfFZH8Y74ktTavhsyh5VNSMh/Urew7Q94yHfa1jthYHrelGv2BKrkupWI5lKeRvMCa+CXkhHOZOztE6ifGH7NbsH2E+aKe758caCKSY=;24:uNqqO81m/qDlAzdNLxrSho6SaU88VjaQLS94fDxAyVNhrMiEDouosQolbCqEYqHVSrhpRoVYOvprYIoauq/kw8EZ+w8HpvhtTew9oTtQrpg=;7:KwQpZFIp7RRfIeUkf/1DUER+sZlaRTPTglwBizCMcmUVrJyGVfK4q/gKID79i8nHExB608XR9RrmtXv/Q6UV93dijEd0wZ7ZlQu500YcJQyuCxx2qGcyRXYZBF++2PRYZqqAAHXRm4TYx2Yju1YGLlqePjJ64/h1BJxbjkARLnVtyOrKNbbUTyNhPdIwjUaIegqzmMiap9S+W0flYxGwXapQ0zHgbTw80fUzvhpL3XIGNH5Pgiopx5AvWQXG5vFC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 20:50:24.7210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5802d96b-7781-4568-d4ad-08d582dab852
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2854
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 01:42:12PM -0700, Keith Busch wrote:
> On Mon, Mar 05, 2018 at 01:10:53PM -0700, Jason Gunthorpe wrote:
> > So when reading the above mlx code, we see the first wmb() being used
> > to ensure that CPU stores to cachable memory are visible to the DMA
> > triggered by the doorbell ring.
> 
> IIUC, we don't need a similar barrier for NVMe to ensure memory is
> visibile to DMA since the SQE memory is allocated DMA coherent when the
> SQ is not within a CMB.

You still need it.

DMA coherent just means you don't need to call the DMA API after
writing, it says nothing about CPU ordering.

eg on x86 DMA coherent is just normal system memory, and you do need
the SFENCE betweeen system memory stores and DMA triggering MMIO,
apparently.

Jason
