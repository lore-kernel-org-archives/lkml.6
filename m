Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDAFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24121217DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BWskWDQf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="H9OvnHtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24121217DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeHVF4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 01:56:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54930 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbeHVF4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 01:56:31 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w7M2OBgs022558;
        Tue, 21 Aug 2018 19:33:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=xF6J85RkJwnkLDB/w2qu87twFj4Q49pyRcJ07J4AZFg=;
 b=BWskWDQfYuupv0uf0zBgiIL9QO7AWueRNmKH4rbL1zF8uIS7bKgUAYn4XYE5DtBH57wd
 EJCKd71ZVmBbYXz4TGq8eby8XGzV5/KnG+iA03lgzBsz5Ui9gxR4/Uju+tYVPWMuDV1/
 1C5SvRMf3h1cCjBHzQbi1Vb1PxXHf8CMlf4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2m0uhnrh7j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 Aug 2018 19:33:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 21 Aug 2018 22:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xF6J85RkJwnkLDB/w2qu87twFj4Q49pyRcJ07J4AZFg=;
 b=H9OvnHtOkxPYmHl9anDq0HfI0+u/JAHJ3mGGC+7LgPA+GwwIAReVh5Ogn0O6nWVjE+XcAOsMHKqyC/FrczMvv9h527o1vXis5piIOt+xx3qSZiQxDTFdVS7KbM08anCk29u0S0H/rDrjHY6sTZxAToVqIu0hAp8GVbGRmKZEuBw=
Received: from doronrk-mbp.dhcp.thefacebook.com (2620:10d:c090:180::1:4035) by
 BY2PR15MB0469.namprd15.prod.outlook.com (2a01:111:e400:52da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.19; Wed, 22 Aug
 2018 02:33:19 +0000
Date:   Tue, 21 Aug 2018 19:33:08 -0700
From:   Doron Roberts-Kedes <doronrk@fb.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     Tom Herbert <tom@quantonium.net>, Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strparser: remove any offset before parsing messages
Message-ID: <20180822023308.GA5970@doronrk-mbp.dhcp.thefacebook.com>
References: <1533854411-28184-1-git-send-email-asmadeus@codewreck.org>
 <1534855906-22870-1-git-send-email-asmadeus@codewreck.org>
 <20180821145321.GA44710@doronrk-mbp>
 <20180821193655.GA15354@nautica>
 <20180821211504.GA76892@doronrk-mbp.dhcp.thefacebook.com>
 <20180821225113.GA6515@nautica>
 <20180821233549.GA96607@doronrk-mbp.dhcp.thefacebook.com>
 <20180822004647.GA10656@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180822004647.GA10656@nautica>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:180::1:4035]
X-ClientProxiedBy: MWHPR2201CA0057.namprd22.prod.outlook.com
 (2603:10b6:301:16::31) To BY2PR15MB0469.namprd15.prod.outlook.com
 (2a01:111:e400:52da::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc59e308-13ee-4b43-2ea7-08d607d79fd9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0469;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0469;3:5jn6KFTRlUIP0lH6dX962yIzfNJ98iFucJlR7sNSgsbbpv6qI1rPt8KYIF04NICGKcbUf2HPcnWvKXU746k6nuJXrPTZv4z0zWZ5yA16rT4Gl2AeGYOeYv/UcR89wwfYvkPeRC1oxASMQmG71Hr/7JhCzZ9XlwmKadgplW22VuBGeLQWeXr7v375Jrtm5iJyz+K8JYhvuZDNlW44bIk4mwaCoL4pcu+5kS2xC9hGck8ZvZeFbqsyiVxoGkWlaPko;25:lpeXY9f1WxdJPEdnt90dO8f827yLoT+tEd2yMqn4QJrOlLpD5+7UCtZWc0m98p6uPEb/23DdArAyOZ/S16xlykwZUBiZhFhK34CH5MPnaIXpRmlsX534mEHzsQ8iP7AFQML8eJ9A7yfKCyp4dOnh6KugfSMTANjzUdpDtgBsSpDDygbZS7HQ43GLPzHOBK20NDh5PgfYAy/Yj41bFvKip8QgaeD+HiWM2m5tkrbqEnU0rcbAMqjO/y5sk16/PFbR5LCLko/pXT+rds9ZolUuI+s4fDOciS7hpEPxBNKLAyxWntHUhhvIcRBFtSbU/FqYDm+Oitire61E0AToNvSKWA==;31:I+hGRMzu2a4tmvCzF77OTqeOST4wpavA4DzF7N4zRx8k1dR5qd9JXg0/avcLSYqq+7T3B8JO3SCqaZfUkCeHHTADdVWoZ0AHT1v2tk/X0MHQoW9u3XNhruIl+mJPhMxGpJCrFxT5KmLUCj3MxzKZ/Hh/3F8bJGO/uDKgZesYGY/FLVHLDNB24zaBTmbKez0DDeFOfojH1lIyrTISm2F9OrwPmTixiYQx908v/4ri4I0=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0469:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0469;20:mHEfE56L+nrcoKAmud880LFhB7DPSQSyMqehmSQinxiplQhM5pHOXhGd3EHz73b1MGGYWUcCZg9yDi/ZFJwB+eh88/tLp3Yz3FYV+J2TjpWxtSpc2bBusUmQqqhxhjkQQu9e4y/xEX4GRtaA1AiFl6QoxfALMp5170ix5gUAea7v+g3EpxWK5Ji/tDZ+E6wbLrT5+E7qisvCJlBVzWNIg1urz23RDUlcLkbK9KtlEi5bdfTJYeyY/L7lTeB09pNtVDCR/FTKgju4tJ4WgNKRIqBdk517e793TZnsGLj5Oa2ls4kuZQ7H1U1U3ekZ3zeABD6wKeOAQCYLyohpZs+DG2xAk7NlJQDoaucioS3vs21DpB/gvmyhORKfl7hA7kOBE86fliQmSDlgntNRHqEEfJG8JVrc4X1DPO9LUC7C6QfBfkPyd+jUtNhySZLiNdzpixXKJwC+UZ144SswoSoe+KwXdBpNy46N90nW6meDVl6ujdAIPJMR1NWs5CzRfukc;4:T3IRAJh+Wb+SItDgDAWaK/kAankpavlRvLK9wjBu+ummrdIg8Q79bgmxsQvfULcWtcTi9lBhHWSZTe0uawJUJAwp2K0qtuVukjobPLQtIZiSSriLPbGyvsbmV1qal4F9U8JGJgWbb9TLbTp24dbtE0smlD0r/p2isj4Xql08CIHDj50l17Pv/aAFfcYnrVEHORUuA0p/PrLs8a5qgOWE+B1nT+Da51KNswLOZoaMVZ+WRYM9k+NXwmFyHphp9nO5X20ktY2vLcSYOic/I+WQMQ==
X-Microsoft-Antispam-PRVS: <BY2PR15MB0469BFA7F781362B604DD2F7D0300@BY2PR15MB0469.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:BY2PR15MB0469;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0469;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(76176011)(186003)(16526019)(52396003)(8936002)(4326008)(486006)(7696005)(11346002)(476003)(52116002)(2906002)(25786009)(97736004)(6116002)(106356001)(386003)(6506007)(54906003)(58126008)(316002)(16586007)(81166006)(81156014)(93886005)(446003)(86362001)(46003)(8676002)(6666003)(305945005)(1076002)(68736007)(6916009)(33656002)(7736002)(229853002)(47776003)(50466002)(23726003)(9686003)(55016002)(6246003)(478600001)(5660300001)(53936002)(105586002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0469;H:doronrk-mbp.dhcp.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0469;23:+O5gVS/Mz/SBgaWYwLYXrY439cswXr1WSBrF6rm1D?=
 =?us-ascii?Q?NjchgG8gcOHXYEiBRhiqjOnyV0AY5JfV67Br4CATlGqnUlNKiSiVgxmaP8Od?=
 =?us-ascii?Q?D9S2JMfjPg3VSf7KtnAg3eyJNlBLpl88L1zvWL+qkDkzJxNWSQPDWJEaZ6er?=
 =?us-ascii?Q?pmyA3OM49KGLUTLkfiCDu0sy1PD89WONfLzl5ffGpNERn1JnnSsXAJBSemjj?=
 =?us-ascii?Q?7kir/S/Ui8S6OurSbGPxO6wKsbhFeTL02kC0uJ674PkSqh5kJQAXHNRhWRrc?=
 =?us-ascii?Q?M6bWzEugsb+7Yyx7FyDbWv+MLFbGz/6cG0PI9XoCrPxZaRsFw4wJZ5XkF3uE?=
 =?us-ascii?Q?1sUCwQs27uDHRqD0Z5uQNfrok09EMj6/saNDTZKLK5mIZ/sZmfP76G1GWI33?=
 =?us-ascii?Q?8nB3uGIGgfo20q6j3VFbIFjkDOhAoT360TzxDc7a17Q62gDjnrg38ghOpluv?=
 =?us-ascii?Q?0B+kDnxtI6JyjiwTe6p/jEuXjZx3F6lk2ZsXehvFnwKUuz3ZbimoPH7lDw4y?=
 =?us-ascii?Q?0sO18QwtPkJnkAjiWKmUGMm9/XGQnlwrJh2sD4ARy6EzzJIj50nTWR3SLPcL?=
 =?us-ascii?Q?boSSDvF6OVUmFRh0cqA44it+55C+9J7+SeabiIYZJeY3cX9pPTK8nOoXtL7u?=
 =?us-ascii?Q?nlfhrgm3wQZkUhKcivu92WabbyplGkLpCS73wyk/d9kPCp6KgX1bcV+AUT85?=
 =?us-ascii?Q?PpboBVE3CYprWnrTNgwAz4Zz4DQsJxwGqnS15rHx+TbidS7AVoPC7i48x+jL?=
 =?us-ascii?Q?al/FKzfXDYHs11otVsFdUhmlYQlXv3D2vDitd+IKjg1Zt+bKIbFAJs98y4/0?=
 =?us-ascii?Q?uikzR0gFlYRfIbmyiCyNSp4G4LUhkj19sgRlX8yX9B6rsSJY3LUhdGmIYgO9?=
 =?us-ascii?Q?faCWNVXM5rs0wWbN8IVqpbQC/WBJmjSD+WMedfEYfmQNmtn61hyX5BmVVOfm?=
 =?us-ascii?Q?ZbftK1uCUKhKBpFx3TbTiXkWPiexchWZ+7098jCdehUKHCVL/k5Tl4FmeaX4?=
 =?us-ascii?Q?/s7l2c7MC1mD3nODULj4xK6qzJPnPmGCG5xq7mrNcir+ntpwOjbtTHc/q7Lv?=
 =?us-ascii?Q?ryc0pk4E6RBTBxE+RG6vuJN2XOEYBV3dqq5dYAEj924kXqOiMsFnc7EKjAcs?=
 =?us-ascii?Q?Gb4gBIqyX4qXee1cdNr01mIbRZPBwSzATZACNG8XWQB61v5qyFaNrEyMCLF0?=
 =?us-ascii?Q?OW3o6AsqkgFi2YXUEDUbZpak6ZQoThiVSektmz18msh1Qpfl7o/qc19UYqHu?=
 =?us-ascii?Q?M3lDwfjlKD2KrnKnZ4=3D?=
X-Microsoft-Antispam-Message-Info: bzeTPxmSazuABF4vNE45qxjbuilhBZwuVvgHhGlbgNEt2M+5WNLWE2BEnGh5sUVLwgb/gMpUnoTOdm3VZMCe9Ocff/ZMc1NRLwwOUaCImTVUox47LNizqERHdtTgEaN3g/z363mURpTF4EH7uWteHXlQy/62HKaxOaK8qi4SS22GGeCy9Dly/4BU2aL9NzoXe2caMjs2WfZ5iKSibLwacup6J5kpMrcgDGikou0Ahr42wUk+QwhZBgP9oPja22dqTlJMcBxVn7mgSQNw7m30Vc+HENnga03WNjPusNXWzxqlWp0qpNE43hq8LlyKUKCoci5L06EWq0IPO0WTfWZeehn+ysOlq0coWnuYlWU+xRU=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0469;6:8pLEQXndQJZSdkDIWgFnJbnm7o8rukt9aKbm+MbWxNaiFZT+NYm771iqp4rvBBU3t+qKbOwiPtrNta1grrUd6ss7/wMPW5kZTVpsU5TRzX3G82AM9kJazF9Jf/FvjcuKyqRPhh4Jxh/9Nmu/iYksWt6rxgsG//WPiDFx98uiRK+0T/UaAcoxUoMqY3M1JMSJpTlYVElpIWyxB6C3lT9iK1mXNsI+13yzldaBEgHugYaVksKLxSb2HhTRYzp25V/7ABlGg7trhCenhTJbPJL3fWzkcpFEDU0AzPDpK8uQ3fv2KSY178yQV2Gy31N5msgFvUBLfjHV4hFt36cwwjEduXjA9fbeY75kRKfDpZ3xfffllrHpUdG7KSDhelaVJT9FBhSWySKdy5UAli+g7+B4Rnb6qOve1ASezQA69sHQmCuEvrKWgDxLMI8dEGXVLAsV2eyxAwSaK1qT73VNBedXCQ==;5:ybursvaAQD7q+X1iW3Oo4V9Dv7NnoJFbYdtb5UHd5O7cyNKtQnRI971TVUm3X8+hw5+oAZPmF9C/HClRJNjMVJAH0FzxDaV0P18fKiaSwCytX0S3+FBigdwh7Pf+J+ZUD6DduHXVPwaJISCf9PAGynjyLnWSVSJl+vDlVifyT2Y=;7:UFM/GkW3M6Zp8dyVMB1j9/3M6CmJe/FFluBHxJQM51MmzZMLdNpnbp/8nNKCa7H1Qm+nr6jsVIrBai8Y8YjcW9vwYM5Tko51pI7n06IqCnWHGDRhKUKgLXPW2vUd0rb2BZnqrAeO76y8ttEkC5MaXtuXp6HMbTtQLP8Wjy4ddcbZThz1Jta/yZrzx+Te/BRjwPGnvzkAq5wtC1rog31RoiN01R8YAVH2278NC+MQzlY9aOIJWRHjz+9rnf+7HM1r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0469;20:K2Ob72h5G1cl1lDzJ9ZAgUF6k+BNYxoNSvhyL/xswedfbr9bu4zmOTylnA6avKukIclA1JA4MNpLhV+6u0YdF5ckaaHvDyFVntUZgsOimw1oUeScm7qxGpnzA0fUXmvaAPu0kwOrYhGhbZsszO9DrBej5XUaZf/j4QSAjM4Wn3w=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 02:33:19.1990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc59e308-13ee-4b43-2ea7-08d607d79fd9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0469
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 02:46:47AM +0200, Dominique Martinet wrote:
> Yes, the rcv_msg callback itself can get the offset easily, and it's not
> that which needs an extra parameter but the bpf function kcm/sockmap are
> calling which would need either an extra parameter or changing to get
> that value themselves.

Ah cool. Thanks for explaining. 

> For what it's worth, I don't think either are acceptable solutions, I'm
> just stating what would a "fix in bpf" would be.

Agreed that the discussion should be about whether to fix it up in
strparser or sockmap. bpf seems inappropriate.

> strparser logic in that case -- it might work to pull in the parser
> function but it might not work in rcv for all I know, or the next user
> might think that since pull is ok some other operation on the skb is as
> well...

Just to make sure I understand, is it possible you meant to say that the
other way around? Surely the rcv callback can do whatever it wants with
the skb. Its the parse callback that may need to be a little more
careful with the skb.

For the parse case, why not just clone and pull? 

> As I wrote above, I think it should not be possible, so we're not
> even talking about a small percentage here.
> The reason I didn't use skb_pull (the head-only variant) is that I'd
> rather have the overhead than a BUG() if I'm wrong on this...

A printk in that section when (orig_offset + eaten > skb_headlen(head)) 
confirms that this case is not uncommon or impossible. Would have to do
more work to see how many hundreds of times per second, but it is not a
philosophical concern.

