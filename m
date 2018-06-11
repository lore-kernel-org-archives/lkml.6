Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id I3IsFw+hHlvRQAAAmS7hNA
	; Mon, 11 Jun 2018 16:19:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E10EC607A4; Mon, 11 Jun 2018 16:19:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Zlh8AZfH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 37A0160791;
	Mon, 11 Jun 2018 16:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37A0160791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933379AbeFKQTh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 12:19:37 -0400
Received: from mail-he1eur01on0049.outbound.protection.outlook.com ([104.47.0.49]:51488
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932298AbeFKQTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MktT1ncLsvdpGwCPDJ10VZSPooqdMuGtWtg4wX7rumM=;
 b=Zlh8AZfHlh//+w3OIZeE2R85kM0Lbks+6FgI5QwtuJ/geJiyxCL2+MA8u3IOWrClbyzt2hocd+52tf1NRmb4qi8/C1vyd55Ac38GyVHge89wPHw5s+cBQEUThxDEjEP9d9clbK/MWQvyKdEDHPj4MhQtDHK3yhxSAaz9HywO+N4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM6PR05MB4453.eurprd05.prod.outlook.com (2603:10a6:209:43::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Mon, 11 Jun 2018 16:19:30 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fSPXK-0002Jl-Mj; Mon, 11 Jun 2018 10:19:18 -0600
Date: Mon, 11 Jun 2018 10:19:18 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: jackm <jackm@dev.mellanox.co.il>
Cc: Leon Romanovsky <leon@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180611161918.GF5815@mellanox.com>
References: <20180608174218.32455-1-willy@infradead.org>
 <20180608174218.32455-3-willy@infradead.org>
 <20180610063028.GH12407@mtr-leonro.mtl.com>
 <20180610104305.GA9284@bombadil.infradead.org>
 <20180610122505.GM12407@mtr-leonro.mtl.com>
 <20180610203027.GF5560@mellanox.com>
 <20180611043425.GA21382@mtr-leonro.mtl.com>
 <20180611044203.GA32562@mellanox.com>
 <20180611091914.00007858@dev.mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611091914.00007858@dev.mellanox.co.il>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR12CA0068.namprd12.prod.outlook.com
 (2603:10b6:300:103::30) To AM6PR05MB4453.eurprd05.prod.outlook.com
 (2603:10a6:209:43::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4453;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;3:qRjfNmekmHoWJghwxemWS8d0J+wZN53jCGs5IiS+odizlXViBOEOA661TjEWIlYtkaVgeAsdE/zSDxCXf7vvOneXiXVgJPnmB7Pdh2ELItYWFc6zHj++EZYdsEtb5Pe9/8K7w32TZtxwMWieBl1ExKSraZ/XB4CqX4B2Ul9lYA1zWBpe37mef3aTsktCmn0K5J8q2ekMBJLNHSnQuld6ZmtIq8XEdW5mhRfBusQolZ7/+Ik3IPPdyKm9W3U8HTgQ;25:JE/LxbiWqMczGRzaI5r4KDMO6qyJoGCSkvBDJKU7T1K+JDz8XcxQb4ZZ/MftBegJC449jyG1kxKfBwUuZedaSLAcRQe1kUVn3Thx+yNN82WgpXK1eOPsvDFWiSRbEN5bNtR/JDqDMUIeKoeigOFK8COk70lUijarvTRic9f8nJ0Jmx1/bjARtNUHnjkQ8QDWXKE1eueIT9x7eXTrj2MkCSNQMjbe7E2XvVygHodDxEOyn+CnvRaGjBGMvTgsHUdTaOFrD7siC9wxW8+Co3RRWIxbZv3y1S+0R1aAZ+Q4cqW0dkdYVwSBxLOkFiSudM3xIAmZmLR58DvuyT+dYO/e9A==;31:ELQc4w88LyXkJPON1g2X9XCrU1AF8KtAEcS4bq5X4Rf7GIAUzY+JL4XCR6bOhmc9rhPBTACAuiqtB+yc/o+o+YsheIbibivpNaaYpMjEeIUQsWJW06IlEoaDE5oF1JI8iJRzGIuR4CVA+/tRx2DZNVTQhMt1K14DPQXYpCU8Vj4cTNyvnFgcI8pHRvTsx4s9spJA5hDXuWChNja/3JbwBnkHedlGxvQgRmIkBQX1yOs=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4453:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;20:YtIMhmvFBqv21uUZ744l9Z6dEehEiegGe9QEs+6SGn388UpxiKH9UnicoHmk0RDqz6g+KQUiAuxIvYyfLhU3ojpvWtn0Ig2uvAf/3LHUQ4QP3UMFHMw5Jz2GYOUX2BtfWhEqFCHX2AaZfaO/bAgUBoFDL13mXsj/yKYDW0DGZTPEwIRFt2y7u0GWoSFZ3pUHLVuSM/Hrq1DguezB8MSlZZ1QVCGQwBhX823BbQRJTAdYafbirKt2BWqRt30KszbDjXmRlCWu/t7kh7pkbglCX609uVIfYHIKppVKNrqqtVgmPvREmHFcLQJ2p06t50wMD74By3mP7UFBWHSpdLtDVlCASvomEpbI2X3pYMxb5N6+I+5fxs1G3xgsqSnKfwP5hqNtpm/idNf+Rd4Oy8uvQxDhVq6+/EtvFYW8vpbYSOnEepYX0n23H/Fseu41XtgHMhbwYTMmc8Qt26uhNSGmb/g/zE1Tza3oqhpz4DKmtpQFseLDBZZ6EG28NVOShAr5;4:E7Fv1hURRhmtViFlF92fRHycvyvJBZqK1QzWsptslyHeEwIdWKx8YgpybLAHQ/K0zn1OF/K9r+r5cur0FcwnzMiwntcKZuv9rjIMzr2XvW7TjTE6O0M2+mYscm3l0KuTd7h8yQ46rRFnwvs+4/1dLJ/Ql4BqOgOXsoxu85LWatGLCXQKlIcLS9DFB4ZMISbqkP9q0qQW/N48Hpw9cISWoDoIrsRJSCpA3vOleDKovuwIwHSkqr2iD9btSpSQ14rOQVZPuYvwHADbYIEkPIWMSw==
X-Microsoft-Antispam-PRVS: <AM6PR05MB44536F4BD6FC071B9363B142CF780@AM6PR05MB4453.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM6PR05MB4453;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4453;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39860400002)(39380400002)(189003)(199004)(66066001)(305945005)(52116002)(6246003)(86362001)(186003)(46656002)(47776003)(446003)(11346002)(476003)(53936002)(68736007)(26005)(54906003)(57986006)(9786002)(76176011)(9746002)(93886005)(229853002)(7736002)(386003)(478600001)(83796002)(23726003)(5660300001)(316002)(69596002)(8666007)(6862004)(39060400002)(8936002)(106356001)(105586002)(8676002)(3846002)(6116002)(36756003)(59450400001)(122856001)(486006)(4326008)(2616005)(97736004)(16586007)(50466002)(33656002)(58126008)(1076002)(81166006)(81156014)(2906002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4453;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4453;23:Rjd2xHFo56ue/QIipW4fN/1+Eon0nevLsGdeVHlOd?=
 =?us-ascii?Q?Ox+eJFrTAWkw5Hwpas/s+3ZUzHhafbOEEdrN0B+ezkIg7LT4kzVfQ4yQLzsl?=
 =?us-ascii?Q?pkHB01xpq/bvK6f9N11MPVRJk+raIPJqWUGArqWchn2wtCkF9U+6z6NHXHC+?=
 =?us-ascii?Q?2HGhAcglRQ/TizMWRtF31SvigoxD3tFkIyG5WnHDiVy2cpMwKBecwffxHKmf?=
 =?us-ascii?Q?pFT5wnqa+FIf1VbYe0XzXUbe5s5xTGRzJLJg52m3wBQYl6TBad0FA9EFaGGr?=
 =?us-ascii?Q?0axl2CsiNkcNvDg0BjfLxx425ZZ5taARSTwpBG/rOSR7liwhU+BW66ot7Mck?=
 =?us-ascii?Q?50wad3vrc72oL01UINyCzFfzZOtr4BLKk13VpyOzG8OivFW9P0OkZ6SRyrgR?=
 =?us-ascii?Q?flCkr8fAf8Yjv0DklAW1BtplaodLgnsnTl45F7oZVGhfWTKhmlkfB3VKzKJD?=
 =?us-ascii?Q?17rL+aaX9APyxupq/TDNxaxPrxkB91Ea6iR9WYKdqqqAZBszUEs8AGSEv/bG?=
 =?us-ascii?Q?KXX6nr3+C2EBDS1rlg2CVY3y2A6zoipZY87EWs98YHnOfEGrkKiSDZH/qYrj?=
 =?us-ascii?Q?Sc/a83z7VDzuuuTVgs7rb7dHA2Fu/gBwSOpkHyp2W0IQAkZDCxhSrvsZpin6?=
 =?us-ascii?Q?muI5/2F6tAM4dDCS20+fhCUIo9L7ONHYyBMmsxtR4ml3lfx2bIHw5UQAtOD/?=
 =?us-ascii?Q?wAR/zY5hLPtoYir0FuRtEqtsSz12b9FrOjyiEuE1vkLRiXes6B29sOdOAXYy?=
 =?us-ascii?Q?DyZ5dqhRmrY7e2U+wVn7/Oj1ddivZvOZFip6g4H8FfND9Rkt28EsNNj/7VtO?=
 =?us-ascii?Q?dt7xgASVM7+l0YdZQS8yr86L17njKSsPq9hyckWHtBC2B7/E/VY2yDPlF8Fj?=
 =?us-ascii?Q?3P/MK1ie0t+BWjPihb2oSgzp1FOcD5+53yBDWZdf6uReDK7xOFzZoveWGL6M?=
 =?us-ascii?Q?5uZ03yx4gmavM6MIpDbggDzk68Q0naoLVMCTm/46+dqq+tTI7V+NPIwSgRGA?=
 =?us-ascii?Q?e0dkftGjPsNb8kPvFnpSQqhRsRooCRzRC8k0e4ISFbuPd2V5V+siuSw+kCvj?=
 =?us-ascii?Q?ETslHjfDQxz3RXjzviagCl8ycwQHCKfhuOFQta7fdzLPp1ZgaLRIVphLrTAl?=
 =?us-ascii?Q?onJsUIJSaiyORJs9JBkjohQYxYiaW1KM3pv8ufH7V+1Wgmar681y1PRk6SiQ?=
 =?us-ascii?Q?LNs7wXeU2Yybe/qfhYT4R5Ins2IWwt4C/1wonYR5pn3SDq3HqV1D00qdwSR2?=
 =?us-ascii?Q?P6DCZYBfABh3B/V1GHjLTx1ElLyjcr2000dx5wl2kg/tZANDfMDN6FFCHQcX?=
 =?us-ascii?Q?NmGHiwasbxdSkdp69apqlz/TXcYEnUmITG7o6Oigm4vQOtKm1AkZ7Wbf/ay3?=
 =?us-ascii?Q?12fguyj4ajKQYzDLhg88xAiCKBA4B1Qh0aS/13wCnEBuaIK1lQXNwZ5M7a7e?=
 =?us-ascii?Q?Hq/iELCxSWeDhqReI42ykhZNSorwDQ=3D?=
X-Microsoft-Antispam-Message-Info: HMI6qPaRlyH1315pzv+W5Fpq6vZGxPr1spoNaus7Ngo1v7FESdjLfOBNwJvkQZKaIRJ0fJD7qeu4xVP40nH3rp8INfUNlZeIasAfTVuuuQ0biTBFVbVxT8y0dIzgRWTd/BxELnxHNYY3M969HrVLMp+ttsl+oZDUehjl/V7VKjw6k9F5ypTqngVjU2oTYk0c
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;6:1fx+2r7Wtwt1NjTj7rmmu/X90Db9zS7/N8UxvqdAh740ZO0F+rBK0xXaIUvYLsCzpfgBU4SQPGFVVrAzWywBv7SUoB95UcByuyke2iVK+rhsXmsZJwcYn6kYzZb6sfJ4B58CAlt11euJpbDvSeBUnAeeKz+aAMqvZfRXJhDExxV3OmgADn7SwRfffLOAXH54I3UAXFhbmjcyYxC9L0qi4B30o1Uw9KXIQ/N6bJNUa9fs46CJS8/PR2iPa8iO3h+cNeBXUn8mWeNU83BEw7mSRtE7BAq9c8Ik3gDbC5cvqFINWfS4LxBOgm5OsGVL7chjoh9+4yop1ZyHyarEkIdDmvhvgCwRwMCzs/Ye/nAYpedmF9RnFghMc4c4S8RNq5zF0lDfzyICIZyi50unNkaW9MOhWWAJc9wIgyzgs8TnUk4DJ+r3LcG423k5Sr4UVjmJnugWlZ63+ZUw1EzT6F4BQQ==;5:me+eutT2wiEQ1NyxTrqHP2SMhszV/cBiWT0MdLwPJKZreluChK0+yhR8+gOguBAbZckYerI5RPQr0hpLt6qDiJPv9aMexqNft4SSx9heuzP3KSAC4vvnHZlymdZXGCj3v3SPBib+WVWX3XNDds99Oh+1wVyHSv+BdqEOiJD0VBk=;24:Wd1lnSTfp/q+139o8LMRrzmE79Q0Btv1GJJdsj25fv80n10ScJSdCGvbZRRGH3YDHWewxdJTKXO+PGCE6ybj3DQHbVN9VouIdTYmMkQN6iE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;7:vPQM+TQbv90S3E9D+p+s5qmSqdkp/Qw5RUuVS09JjdYPS2VL57M07M12LhQnIXyDPKtVR3Vafuu/pRY/Lt+toksRbH+YPTTJb42XELgqUk0IrRmszeevENCcRRjydBtDoyxU57zkio+lr3R8qL/KIn5iovpgYsLBlHlebTVVcY9b6jBn0pBis2hz6kF8TuQkiz7yZ68aHxBToRoQfEkoI+A3hjzGE6ypwhbm1DA7JAdomRN9jOmEGZKoDjA45Ac7
X-MS-Office365-Filtering-Correlation-Id: f47475c3-542d-43bf-d59e-08d5cfb71c94
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 16:19:30.6402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47475c3-542d-43bf-d59e-08d5cfb71c94
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 09:19:14AM +0300, jackm wrote:
> On Sun, 10 Jun 2018 22:42:03 -0600
> Jason Gunthorpe <jgg@mellanox.com> wrote:
> 
> > Er, the spec has nothing to do with this. In Linux the TID is made
> > unique because the core code provides 32 bits that are unique and the
> > user provides another 32 bits that are unique. The driver cannot
> > change any of those bits without risking non-uniquenes, which is
> > exactly the bug mlx4 created when it stepped outside its bounds and
> > improperly overrode bits in the TID for its own internal use.
> 
> Actually, the opposite is true here.  When SRIOV is active, each VM
> generates its *own* TIDs -- with 32 bits of agent number and 32 bits
> of counter.

And it does it while re-using the LRH of the host, so all VMs and the
host are now forced to share a TID space, yes I know.

> There is a chance that two different VMs can generate the same TID!
> Encoding the slave (VM) number in the packet actually guarantees
> uniqueness here.

Virtualizing the TID in the driver would be fine, but it must
virtualize all the TIDs (even those generated by the HOST).

Just blindly assuming the host doesn't generate TID's that overlap
with the virtualization process is a bug.

> There is nothing wrong with modifying the TID in a reversible way in
> order to: a. guarantee uniqueness b. identify the VM which should
> receive the response packet

Sure, as long as *all* TID's sharing a LRH are vitalized like this.

> The problem was created when the agent-id numbers started to use the
> most-significant byte (thus making the MSB slave-id addition
> impossible).

It hasn't always been this way? What commit?

Jason 
