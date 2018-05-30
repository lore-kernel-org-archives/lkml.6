Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932532AbeE3Vb0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:31:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49200 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932320AbeE3VbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:31:22 -0400
From: Chris Mason <clm@fb.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>, <hch@infradead.org>, <colyli@suse.de>,
        <snitzer@redhat.com>, <darrick.wong@oracle.com>, <bacik@fb.com>,
        <linux-xfs@vger.kernel.org>, <drbd-dev@lists.linbit.com>,
        <linux-btrfs@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <neilb@suse.com>
Subject: Re: [PATCH 10/12] btrfs: convert to bioset_init()/mempool_init()
Date: Wed, 30 May 2018 17:30:35 -0400
X-Mailer: MailMate (1.10r5443)
Message-ID: <630E6353-552E-433D-8022-D1FAA93B0209@fb.com>
In-Reply-To: <20180520222558.7053-11-kent.overstreet@gmail.com>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
 <20180520222558.7053-11-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Originating-IP: [2620:10d:c091:180::1:986a]
X-ClientProxiedBy: BN6PR08CA0082.namprd08.prod.outlook.com
 (2603:10b6:404:b6::20) To BN6PR15MB1876.namprd15.prod.outlook.com
 (2603:10b6:405:4f::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1876;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;3:UsLgjNLCwR2geCaIkshC5STURT5yvL5JzEgWSv80aJz87/0uuMwN5/BDVbZOLvhACPu4U2R2bgfsW6qC4tZ0WHf7JTyTupWq/Kx0kesaHy5IM7LYZZaOV7DJJOSi3VG33lG863j7CvAqFYIFur6PduIKz78vNjsJy8MyaQedw/eCGt7Iy79nmLPu26JfTQ+A1v6t7fj98/C3LAyhLufDDPvFS2h3MlXKKyqvOVi3l9PF6ght7PKrHWyvZMF/XAjm;25:5j8VV/32JjFtnCUoStllMAMLxQwKWYXi5s5Rl3Vl8Mi5ra/IGvz4dj/EU0jMy4XIqWYDthcJfeavxdgpEuXOQVk+n4NN0k8CLMwOPFmGBFqD5ag2f9AVIW7cbF7CRg3MVd3giX35T2eJ3nTIgwCUCwfamOng9ddBq9xB7K6fY4iO3v7onUnLx9ZtyxkIhLSy9HT/4CmXDWLH9pxpgX4y3fO2WTY4oZByW372Xy/OZFF9TobZwluqqu+c8nGdLOJy6H36I29n1nTdo4sAX3N+wYzZqft57QJVn79v3N1pMu7FpSvS18+C4B/pvcXY9BsX4CUqnKQfJDa2/o3AEftNuA==;31:yNOWi9hSKUwD0mCdtSFkN+dlylLBvTOgRK2OZSOkZHVkLpTLx6+PeP4EMpG6Crnxq5flUTpm5lFZcCTT5hnO9KBJXLi296yvXXbcW5295WiZSrm4xE7TDgvJ7WSFMakORsh9F9Nui97W9nc7F/2Pglu/abuXcAdukOY/mzxQKooYnC2IsJyTbxGlwWeBN146Q1nLCOi2ivz34+ca1NLEuXLJXPMMoE5MXCDRuyyqQ9w=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1876:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;20:hgw0Zp4LsaoCg4QEravSdq5gJ5eiQSDhqs/gxPDNMH9KsjbO0t3EjNoye7S8W5qxuJGRMB7kfhib1thT+xVLKbZnRUBVCxmInb7zUMoXezKZGEK7g5tJG6LY8BNu8z80x4mjK4IMlDsckQamfYa8d0lUVRu94yQ4bYuKyaJnSEp1cYE9AkHcp6Pcnh+oA+v3oRg0mWyz5PCcAMTPgMXpviacPpDmcOEqRQ3I2NfBdGUGVWJdYQAg9UXVPSk++28qF6rDbAbTzKskVur78gWWSLFND1NLLzsjlmB10CnXwZrNPU/Bp7edcZlrrXQuvQK4I7HGgoOyflVEnEJSyZiTB1jrxGS3dx49G22rKWtASXJe++KZ2TT/qKdM3KmHtHOixMCm1wTGQMmFIzsOPZVgzL0ost+3GqnQIsiaeRsp8eoKwvrixCXN+qy54y8G1F6pY0Of6goQBjZxg+pIpuWOK6mxMWbyJ4Jk9un1GBP866QFsFyUky1VC4Of0SAZPb7S;4:dpVmCNqnYAGB/6z/hPVXU77Jk3UVakOFlYBVubMsNRbSvC8IpGzJSpl/zKeiR/UtPC/W5Lj7XDRj9E9IpS3kFYcAk4csLjlfqqAeNeqtLwz7hAS9L55JzN27zMw+J+5tq5a6MfWH0xnA4DLFkF3ceNUEU8gX5InD8yu7t2I+eQAKIkROMdL+if/f4oFKXHyq/nyVWSDFKfgX6R3+78yEH8xZxUbaKQseTgLawgZreHEHLBykp79JPsplW6cyvMhgHNHYrlKmECE3ZaITLfUVvo5NDhNR/6ZlX0s9NwWcdBUvhG32fVTSy8P3jAas+42tDxNAuecs98fVKk+gHyjnxyOGbOeDcG3kxI9v7SvqIEI=
X-Microsoft-Antispam-PRVS: <BN6PR15MB1876C9933A3A1ADFE1A805C2D36C0@BN6PR15MB1876.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN6PR15MB1876;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1876;
X-Forefront-PRVS: 0688BF9B46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39860400002)(39380400002)(346002)(396003)(376002)(199004)(189003)(6916009)(8676002)(2906002)(81156014)(81166006)(106356001)(316002)(105586002)(82746002)(6116002)(16526019)(186003)(67846002)(86362001)(486006)(7416002)(476003)(229853002)(83716003)(47776003)(6486002)(11346002)(52396003)(478600001)(53936002)(2616005)(305945005)(6666003)(50226002)(7736002)(77096007)(46003)(53546011)(5660300001)(16586007)(386003)(8936002)(76176011)(52116002)(446003)(51416003)(4326008)(68736007)(36756003)(6246003)(97736004)(50466002)(33656002)(25786009)(39060400002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1876;H:[172.30.100.178];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR15MB1876;23:dtg8kLatyKhyiyUp9olGRuBf4puCwekgwiI4IoCxj?=
 =?us-ascii?Q?22t+WljS0za6/JmBaYUhuBbjwWSwh/lT8SA+k7DH5j8ABhozVyftwgShAD8k?=
 =?us-ascii?Q?l1YHQfiv4zQIRQw+QlovprRy/WAISTstLdsq7zhqsFEkKqu/ZgC7+mAuFAjh?=
 =?us-ascii?Q?J3GgGfQ195tzQUGn4q7hUuS1IKpWHAnXp4P2vnz+JMybl8HBT4S0Bixp+cIF?=
 =?us-ascii?Q?/tG9B92/Mg+U/fQpBE6eI29gqto98VI8YqzSHH4vJCgqZLNw7qh5Mj/23Amr?=
 =?us-ascii?Q?gdhKTvWWnUnwupsD5w5G8u2KruxxPneWz01qSiHewzP0/YM9aBZ/7EkKE6Bi?=
 =?us-ascii?Q?ua7vw+77Z06cIOchKf6Yg9PysyUft73Ob7fzF9euzbs7jexpkEHEbhLcceid?=
 =?us-ascii?Q?W3P3WwW/kbXxvr0dnO6GeUQUx70yuWyptmV8cai6wvDvvHXFI+R5ogNKJv2O?=
 =?us-ascii?Q?7YrzMrKmXIV0ykCNHbSm8eXtiiOzaOoDzGMOWLpdcmIGkFQcezY3x+L5jY3+?=
 =?us-ascii?Q?PD8GO4g8y4XHfc4zc8Po64ez61OV/sTiWP9mUs2fEewzlxOYWVS6BtJu7Zng?=
 =?us-ascii?Q?WKEBSqqS/EZMpSDh6onPNRwt+QvBj3zYz3l/anf/AMPCZ45LAq06XI3TUk6t?=
 =?us-ascii?Q?UXomOD1zwZqRvLhnCrW6884odoqb873VMLq0AV71NnwwGSLqV02cqk+5RKiI?=
 =?us-ascii?Q?+3IyBquTaAxJKsD9DKELMquDyl5UukL3rHITBdr5u7ZuJ0ulLRH0UCKFl6C1?=
 =?us-ascii?Q?yAGQNAdUXAF5iwo4SXK5iDMVYIcNPKQtr0b9b5KiSLjvfOqOpVscJv1yEbmy?=
 =?us-ascii?Q?xKNIVFnA38e2sqbkuUv0VjRp7UYUiykpJw1U/olEh80zyQXvB8CGLvZi9gU+?=
 =?us-ascii?Q?3S3MoxMsMYTuI9EU73murBF81+bdi2qh5r58Y/xwvm7Pk1XkhYW5MCuFso5b?=
 =?us-ascii?Q?mqpC2fF+FrNiWImdQCQXQ2ll94MZY9R0VnT4IJA/t5YbVxa0QyuYyrQbwXBZ?=
 =?us-ascii?Q?KkVczwU3+n3HVDbKrvvsqylux1alJsvr8CYdiL4QqflhUikH0sOpxyKIuSeK?=
 =?us-ascii?Q?shTdPLYMiCvQixcT0thIR8m3fM11KJIx+DNifS2Pmx3CeqqVP7e2bL78+qD9?=
 =?us-ascii?Q?FoHuhhgQqREzyYHHFZPmsOvHc2wp3EUz8jJ/oYxhxBKaCN1XLvRljCYUrAkR?=
 =?us-ascii?Q?7IvS1z7XRCHXUy4nqywEf+Lh7rZSRuc+LF4pawzrQv5k6BSaun5bKzsOsziD?=
 =?us-ascii?Q?0rWGTeQLQDHscE4/wHrcZ98hW9wPfCGGMZa0JseX+v1wFt/koEIRCjGuSJY+?=
 =?us-ascii?Q?2scrwiuPvvNvQFxwCUQ+qrGc61um2GL77iIQMK2zR8f?=
X-Microsoft-Antispam-Message-Info: 2j0gezJ5s4q1x4Th4qsaWi5DzVqHiaWYz0TfzLHvRk+fPO3VcPVIpGhGdQDBar3OkrD2cPn7TRLPdk9tZncinslaF21lkawBxzs/MXtkUD+IbQGTHXoKtJiHB0XXgCwspXlBLGzqhVvAEHS59Kk1Uu8IDM6jCMCEGEWfPJm9TnPA/9ajbeVwfgJ6NaQcYV69
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;6:z3NgZeoYBlGiz+UPWAa9nZ2M1pT+kGYoef7hwK/knys56fAYzGoeOZjGFY1u6XydPV0C8k6WDHXPrAe64xf1sW17OXqdn7KUls3d6mCxeA4fbpi/kWbfDkm2Ob4/aAejmt/HWNBkRRDvCc47FpRwQnj5fVSolIsfeXMnUs9oo1+E+gU4rwWLXJumoDBtbYLCCIpKplIrJJUAoeFk0ILWlMu9tc8/Rfme9YQLURpCqI3gtHPoIyrcN3E+awU68yukrrU3bcURwN2f7zz8kupuSzj/+4T4C2+2sa9m9W+f8kSBaVUGNZ7R+ZP5UaZFCLY2BL4bct2OAivNKWee6b9rr2doZFoJFxDhnjiVMYO9CkkEgh1oLJbjrgg/BLL6Eke76Pj1eUKurlg6GyqrOSL9h0VOuFlLxNTmN1LelbObC36fEPz+tz++9kuPulYxwr7zaZJrLsgHszeR1HtCUMB3gA==;5:GQuJ2NVjj8T5wX4Lh4R7ev3S6TH41MMGm0lx70SuvkC7yl0G4MYeFRqdnx3IN3wv4voKekZIh80B9CeV46P95LCCQJ7OnmbJvKqMz5w5ongT4WDZzTpQrDATiGlGKxRDvOWbqsU/y+0Oce628UvT1UAluAap4xgXkyQMIUU5/YM=;24:dOPsqO3aPJCR7NWadf3F2Amok9d5ukaoRduaYGx4e6rEohio41LBQBhGRaD+h3V9kQTshOHaNzVeRnBF3CroCuSXnSiSSnF+qaOrhhFqMrw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;7:E6RcbjrSwosVykfOzJA27BZ1cpVKUJ6sL5ZbIVEyeVDADcSvSmmuNNvsOBpKE+OVmQD2qH9GmJtbFbL52Vl2AWcQ/tiJX4rj8Jc/4/4IkmhwvY1atvP/yyl0suyxyJlGWvivNTQLIEGIm0hE3u9iqAlpDiLp6N5jMMFk+APtbL1PcnTY+eXd84vG7PEMVv5O5IhmvPWlgDYT+zKPu1DmF7+IGt1GKtO+3WCHVD1CNK5264vXTVcmCGcaD++Qxvum;20:zPCdHYo32c2kbw51sBo9RBegcVov0+IBTJmp/NfYgIRl6jMfJ29aqwV1ob3wOfJIFUUOBf7bezTb2jEWNHft9XDZOcZdJF5bD4jicKWvboB0ug/CX1EvHtbfRn+Nc/X37lq2Umjq6Hnzu6tU+mgoLlG8cYxc4gFmSTRM5znv66Q=
X-MS-Office365-Filtering-Correlation-Id: bec579bd-3a46-4ff1-f922-08d5c674972c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 21:30:38.7449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec579bd-3a46-4ff1-f922-08d5c674972c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1876
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 May 2018, at 18:25, Kent Overstreet wrote:

> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  fs/btrfs/extent_io.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>

Assuming the rest of the comments/questions for the series get worked 
out, the btrfs side of this looks fine.

Acked-by: Chris Mason <clm@fb.com>
