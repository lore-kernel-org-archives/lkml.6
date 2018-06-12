Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DFCF2C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809C5208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="xzhKIPc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809C5208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeFLOeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:34:22 -0400
Received: from mail-db5eur01on0057.outbound.protection.outlook.com ([104.47.2.57]:19744
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932803AbeFLOeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nege3c1meP8ZBEmxIOoF2MNgmQLP3G9SRoCY1dZ4W18=;
 b=xzhKIPc7Z0R88PJj2xVpFk9grnVFcf2+RTIbItXYWE4SiGg3FJDnLIt+PQmpEN/t8BHg9+CvxRYcMkzUttnjwz4Ql5yXF9gpbKAX8jMQVrKFchhC9YPVa/E9xHV8YAhXbncigT7Tb0XA8z7Kr7Nfjb1wqv967rqiyuDnw3gmyz4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 VI1PR05MB4464.eurprd05.prod.outlook.com (2603:10a6:803:43::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Tue, 12 Jun 2018 14:34:13 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fSkMx-0002da-4I; Tue, 12 Jun 2018 08:33:59 -0600
Date:   Tue, 12 Jun 2018 08:33:59 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     jackm <jackm@dev.mellanox.co.il>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180612143359.GE6328@mellanox.com>
References: <20180608174218.32455-3-willy@infradead.org>
 <20180610063028.GH12407@mtr-leonro.mtl.com>
 <20180610104305.GA9284@bombadil.infradead.org>
 <20180610122505.GM12407@mtr-leonro.mtl.com>
 <20180610203027.GF5560@mellanox.com>
 <20180611043425.GA21382@mtr-leonro.mtl.com>
 <20180611044203.GA32562@mellanox.com>
 <20180611091914.00007858@dev.mellanox.co.il>
 <20180611161918.GF5815@mellanox.com>
 <20180612075942.00005061@dev.mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612075942.00005061@dev.mellanox.co.il>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:300:ed::12) To VI1PR05MB4464.eurprd05.prod.outlook.com
 (2603:10a6:803:43::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4464;3:0SJqLx5h+BEp2IIgkUOXHD9e/4WQimhuwieG+KZjyozn0WuejOX31DvZg1FfzWzZ1yNfk7z8hLlg5q9qjcFYGCFzNa3GXjA61k0UXaOLw/iDMe9KYsJJhH00mKD8UYdUIfpyfJc5+R/qYlwf+L2XYtRE6dhvHDOOajj0O+o3Xq0w/3qnW9ZQjQxJO0AXUgy7fS2mP5fCmKBKyGGBa9Tz+kscRrChaGyVSodwPocmH7pqdliNKl1RAm4WFrK8YTWe;25:vi/SKBgWuyHkKYgY9T1BYMKWrJE71qxMSc4R3uMWKn4xI930c0jftR3pW2xfB8nmtTlOIJVCVg1239bwWGuk/oJKW4cC5ketPW+OwQ0JOftb4xjI5DN3fRaDA/D7xzehu6QPG336z2mOTNhrBK96lhc+gILMbQ+YP7Ju73R2ziD4EEwUY/hWjf7nW1QQusqY0fXHNLvD9rV+j8Xfa0I2ld1EaccV6mzFTSZ5BvEAn3mI0V2ktsLziVVMDsSEWISXNURbZePAOIUHNIx0f+oYi7SkhzDs3YQLsFnP/xMSQY6IH72AIan0iRDjRekvb+R7eoFPhwDzkm0lrshbpS75fg==;31:gykZWDOgKQTyRA/kutsmK514qrskETvk1s7HnuW2N2qh3BXXh96zAkJQYkzgWoqISRjuszXNrqIabcu+baN9SoKIduSnbFQdiMWOOyyTHQYm6sI2ESWOxkD+Tvr2tmtLkjKDCjCdgYEXEd3CsoZ7crAy0y9msLWNepyNL/gkg3BvGnA0mlQT2DKIKWpTel51swhLWLSPDZcnGaZ7X2Nlns2XuYAvN4nBcs8hCK9LCuM=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4464:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4464;20:HD3oaFYeT4BtZ9nKsthCGtoAQSaeXggfc1cj6UzACAH6IV608CFLQwhFNdqtR5xeGCbenb9pa/WRMw7RVxZaEsqb5Kmgbl+JusbZ4fTw1UvDG9mG/msIabGYjr8rM0k3hjJ9tPWbNnp7FYLW+N814AZ+dQsDQ0ezx5JyfQORLGDaZOn5TWjkIdjOVwM8A+mvj1/JRHsx0jLzfUv1r/gDKkTBoppYy1pIm5fkDHi5qAmZ2EVPTEKd+6vipIxgrtTsWMgbodJK8F+rOIn1Tb/mtVCdprvUU/P1okS0lgffUfwmlRthMBpiUTcXlWSWZ1UPxNyAZj/CoMOvyFR8h5xWm/Jy8+yDGNszPiVpS5mp6eP0VFY12IDL9Ay/Muwof4TB8Q6feUabrPCO4rlinLWyNmEuKjYQz7AVwhhIvjAu57SMrrZJ8vPwXIc7HdG+3NgRCFfN7naM+uOMhJwCRL+7FGkquke63DlRXE6mjTaICqSIJoK8c2NfwySTMfKqzmmP;4:w1rTuP9p78RDn8NAuQbsAiEyCm2EcAOjqv/8CCXM94380frZaA/mVE0u8ZW3mVaADEm/M3xMOtHPiCOugVemY6uDrP2a74TF3w0ogZZmFnM+DcGdexomsgfOzEkNVcIMkwhYwGgdmI//2Brl4HYISONa5KWhJwRev9Otm9uVgA+lC5WRTRWnL7dGLFqNh8MWPM69NV45oHyl5+aX3mn89Kth5XEaMceOptPaztLw0USLD0ND/VrsvCHI+Dmn1zMX1ruxGzfyMs2R47SBK9SknA==
X-Microsoft-Antispam-PRVS: <VI1PR05MB4464E7E3F6A5E1C16CCA0378CF7F0@VI1PR05MB4464.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4464;
X-Forefront-PRVS: 07013D7479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(396003)(346002)(376002)(189003)(199004)(16586007)(58126008)(52116002)(305945005)(316002)(76176011)(97736004)(83796002)(93886005)(57986006)(8666007)(69596002)(229853002)(7736002)(33656002)(105586002)(122856001)(106356001)(54906003)(486006)(3846002)(1076002)(6116002)(23726003)(81156014)(186003)(11346002)(476003)(2616005)(446003)(9746002)(81166006)(9786002)(68736007)(8936002)(6246003)(8676002)(50466002)(2906002)(39060400002)(6862004)(53936002)(5660300001)(478600001)(66066001)(47776003)(46656002)(86362001)(4326008)(386003)(26005)(36756003)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4464;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4464;23:MbYG9NZkqW+MXNCsbGqw0cyl8iaIaFaL8f2FWvhdP?=
 =?us-ascii?Q?vK2irqCclSL5d06lfkfrOQxNuLcnO0I7H0wkRy9HTZHxc+1c/ichPhuMlXBL?=
 =?us-ascii?Q?wZPRYl56HO0OOhtG6/6ogjVWz6zePGqSpjCBRWFD0wS54G9xONT5UYqz9z0J?=
 =?us-ascii?Q?YHDgBxGbYMm/0VKMRBlqgqVBjPjlV+2NqNgLoBJiaccJOAo9PvAkzKFjfhFH?=
 =?us-ascii?Q?igSbs7+y81j5wthuQmQEOC/SsK8EnAep7dAI6wpy6ObC2DdLzAfAynoIbt4H?=
 =?us-ascii?Q?NocJsNpEib9JW6La/aQ/nTk6m6ImM+6fMwTOlQoOrhDoEDcuUQ9CE2qBNeT2?=
 =?us-ascii?Q?Sa4rrKRH+0sT4uY/3rJRAkfdq5DnGa/DSeVX0eGAJrxLpQMBtPlTIobzpEaa?=
 =?us-ascii?Q?wm9iIiFTR41KGO+OpJ3iu04BIlBRZXwjQkDqdbPz3SXkvok9/uq+cPkdGD2t?=
 =?us-ascii?Q?XyszYSYP6/6e+tO0pe11yfEEDRzEY3vdzP4LwUW6gvAYhP4fgWfR74FsvrfB?=
 =?us-ascii?Q?gUxjHxKTi2dyA9yfj0mDXM0KHk8kJTq3G8CHAck1mhoECySs4d4FlVrFqzNs?=
 =?us-ascii?Q?H+Lk4/TJ619iY8YNERKWW+PrChuUXWDr05kcRLz6jJDQXdq113LL22PxMfUU?=
 =?us-ascii?Q?THzDGI7MTOkxsCGTAygOaUoRE3OvPqLWYhPKFnLa2mnuTkyZQnJVvmlSkynM?=
 =?us-ascii?Q?OfTgxHLU4hY2UcMcaN94BTJwD+Y+5O1+xiF0Wkbw0TSHkJC6FjhiPrazKq3b?=
 =?us-ascii?Q?4b6AUgcLo2PWnMe1sDrL4b/PuJ/CwLcQqRMOp7aVEPhbkEFCrDkQIPTllghi?=
 =?us-ascii?Q?U1Te5K/JIjLz1SiP6iO4WwWWdXb3JIzJLOUOPk3/+MgcUWVgyZh+KXzQdWBr?=
 =?us-ascii?Q?EhiIkn5oOBJjWFvsq2VPJ6YZnM1nWw6VD9bE50ofX0MzAu0x0co5w8BLo2mr?=
 =?us-ascii?Q?0qjj+N5TUMMY6pirGguiQG10uQXRO6PAeaHicopHZE7sXNNmI8ddZeQdil4i?=
 =?us-ascii?Q?SPOAU9w12bSCFrd4KJ0qQP9csgegRdG4dSnmcw6K9aLYiE2D3+XR5fR+al/C?=
 =?us-ascii?Q?jrIK4l5qzukdLocb9snShzgt/CgFEEU5oDcs3IVNljscfAddRo1Hzpe8K0LQ?=
 =?us-ascii?Q?DdPUDxSVM7AGC4EkEmKBSPU1YRWXJxY5xFH42B7txCHrL6rEjiJET1Iutc7D?=
 =?us-ascii?Q?MAraSOFNey+1mjkR/IgvQDu185P7OlzKdz/6T6oOgxSsCYC17FeWKCxbqmWG?=
 =?us-ascii?Q?U5Zke6dyNKbrmXw2h1SUPtNiBuOpo2ROpOiaI+7QBncn0J6xn4DLmSgUosux?=
 =?us-ascii?Q?8clQx0gyDCex/KyXAOkDEEemKqA1657rUYiMG0sDoS80bmwKfElE64jGwJ0w?=
 =?us-ascii?Q?2uWJLc5lOUPK6yzhBKc9sE4oraLm3sNRg5fkQJm7cvJPUBbEc9kxt/eT+L3D?=
 =?us-ascii?Q?W/Nq1aj1w=3D=3D?=
X-Microsoft-Antispam-Message-Info: Y6nHpnxL9wphIBo9NLlXiNdaVheRLW0FwENcMQ+ettyvB0Vv94kRtPnq62EaZl13iFK/B4EM3qFJuWWPD3H+F3ELqJOHlXeoz+wQC9CyUxAeanqG4UgP8Cpbr9HPy+Ws/7aCHrRdRvJAdUFFreH554SCKYhQ4e7ejJOxFU8R+wGz3Fhg46IeylxEailvW0wn
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4464;6:YviRWeuVYcPN6SBAylLan1u+cZ5qxSXeQ6fxNPv1cLtMrQXmfJPtZoclRj1nP9WkZ4Dp1RIKoLHGUArAt9e2kKGvHJ9Zl0VKD9tZA4v+wqjV+KdfCQxiiSjW3brvdO1n4F69ZOnxX6J4cr8ZTgPKRS4H8+ma07VZJbFFU6U2io16Yg2D2Qhih3GkmbqgOPqsVzV8MWLYpM0kvv1q/QTWN4cJQkaqVuyi2yLvCQ7Ikfv4pdYy8qL3tf5zzzCfSSGGoy2cDlytioJFK2AYGrMxWLvq8e/Sy1vagOaoe00BJY9ZqM6M92saTFU5WQ495vVDzXnIF+9Jbf6NkoiiE/QprJs6WNyJGb86xbt2BwtHQo6DYtulFvKrdz9xpJSOV7/pfFhCLeWVi+DcjXYOz0uH2mQ53r5He5hcXKzTGiBUNe8RijN4aMEm7a8X6k2UPDlL06p+22sQuhNGK9N8eVf6Ng==;5:+2wu5H4N13+fdDwxxDgQHvdGtgwJJL0OZRRuZVuFF7hCbKZmEp5vmI1czH5ghu4s0p8+TYw8dPw12AUD0WMFtm9ZivOqh4yLbMuKtNrg2Wl1+v7RRXFbLFASo1aFzEGg5cBQOz0UtokeEAxg1VnT93ftSQFX9nPl6oPUiMU63/U=;24:bMrhZmjfIoKp501Hj/ywi32L7BHfzsTwnQQXRBcax4aICdioAW1xAmZ7Tcp4RRfFilrl6cE0m2mzo3GMKJBZSJXx1gfhNSeH+9qbZGqAI4Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4464;7:x2u2y3bXkp1f/OZDMivlGeYv1OvIjsWT40k7ywTwP000DxiHkrBC3c18jPT9RhQ1x/ykZnWPZer0608/wg4gCKQCCr+KvLT58DRBmKRGCDvAqhyM75fsrz1ojjzO36SaaaoQs7yACSCWrnzEI6N9/rT3TPu1xX2Jzn1Ovgs3OmXbkhaGxOSI48qa+Jjvr64qAvZDdbWy5QgxLj9ROmMuzbzaZGVGaJhtiArnFT/VukTTgqXUeh1cK7a+KEB+PWu0
X-MS-Office365-Filtering-Correlation-Id: 8e85a44d-0190-4db1-64a4-08d5d07191ab
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2018 14:34:13.4602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e85a44d-0190-4db1-64a4-08d5d07191ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 07:59:42AM +0300, jackm wrote:
> On Mon, 11 Jun 2018 10:19:18 -0600
> Jason Gunthorpe <jgg@mellanox.com> wrote:
> 
> > On Mon, Jun 11, 2018 at 09:19:14AM +0300, jackm wrote:
> > > On Sun, 10 Jun 2018 22:42:03 -0600
> > > Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >   
> > > > Er, the spec has nothing to do with this. In Linux the TID is made
> > > > unique because the core code provides 32 bits that are unique and
> > > > the user provides another 32 bits that are unique. The driver
> > > > cannot change any of those bits without risking non-uniquenes,
> > > > which is exactly the bug mlx4 created when it stepped outside its
> > > > bounds and improperly overrode bits in the TID for its own
> > > > internal use.  
> > > 
> > > Actually, the opposite is true here.  When SRIOV is active, each VM
> > > generates its *own* TIDs -- with 32 bits of agent number and 32 bits
> > > of counter.  
> > 
> > And it does it while re-using the LRH of the host, so all VMs and the
> > host are now forced to share a TID space, yes I know.
> > 
> > > There is a chance that two different VMs can generate the same TID!
> > > Encoding the slave (VM) number in the packet actually guarantees
> > > uniqueness here.  
> > 
> > Virtualizing the TID in the driver would be fine, but it must
> > virtualize all the TIDs (even those generated by the HOST).
> 
> It DOES do so.  The host slave id is 0. Slave numbers start with 1.
> If the MS byte contains a zero after paravirtualization, the MAD
> was sent by the host.
> In fact, ALL mads are paravirtualized -- including those to/from the host.

Just assuming the byte is 0 and replacing it with something else is
*NOT* virtualization.

Jason
