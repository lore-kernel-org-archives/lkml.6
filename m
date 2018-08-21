Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A63C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE014217C7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nyPxyRXK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Z97aNEn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE014217C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeHVC6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 22:58:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53186 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbeHVC6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 22:58:36 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w7LNXmqt012991;
        Tue, 21 Aug 2018 16:36:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=0t4Lv7ojukoc4r/7k5CvrGC4MYTkebO8zOvnBi8FhrA=;
 b=nyPxyRXK9LcqLbz5qjFQlUsEci0Ny+aKWudVf8HUiv+vfQY5K/HGPnlSwd+yx6WBfYec
 snatiF1swPXQTnkcLBBSrdsKyCHia7azwjFDIaMAdpUwJUVkQt/d8n0p/hWjrNjUecIz
 fcA4Sexry8MwfiCsHn0fYwJnDIT5xSetO1U= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2m0uhnr546-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 Aug 2018 16:36:17 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 21 Aug 2018 19:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t4Lv7ojukoc4r/7k5CvrGC4MYTkebO8zOvnBi8FhrA=;
 b=Z97aNEn7o5XOX7d92sb50ZmXcwPkVU4xabmb+lX5/sW2cerROovmDJ930tKWDN5jYh0uAeO8QYh26oGBqPUoHMOKi7Scd6bdsdFlHFQ6ie/QkfSNWEZY9wqK1px1PTJ8c7MVB70HMv03Yfm28TaAn8IfDlnLE83al8VvGrdNbXM=
Received: from doronrk-mbp.dhcp.thefacebook.com (2620:10d:c090:200::4:3df0) by
 CY1PR15MB0476.namprd15.prod.outlook.com (2a01:111:e400:c436::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Tue, 21 Aug
 2018 23:35:56 +0000
Date:   Tue, 21 Aug 2018 16:35:49 -0700
From:   Doron Roberts-Kedes <doronrk@fb.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     Tom Herbert <tom@quantonium.net>, Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strparser: remove any offset before parsing messages
Message-ID: <20180821233549.GA96607@doronrk-mbp.dhcp.thefacebook.com>
References: <1533854411-28184-1-git-send-email-asmadeus@codewreck.org>
 <1534855906-22870-1-git-send-email-asmadeus@codewreck.org>
 <20180821145321.GA44710@doronrk-mbp>
 <20180821193655.GA15354@nautica>
 <20180821211504.GA76892@doronrk-mbp.dhcp.thefacebook.com>
 <20180821225113.GA6515@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180821225113.GA6515@nautica>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::4:3df0]
X-ClientProxiedBy: MWHPR10CA0012.namprd10.prod.outlook.com (2603:10b6:301::22)
 To CY1PR15MB0476.namprd15.prod.outlook.com (2a01:111:e400:c436::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92d4e4d6-90ea-482b-62f3-08d607bed83d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0476;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0476;3:2aXyj9cFnvp5cvvYwKDF9TRyAVay/o6afCpAGk9JiJGRkj2+6pXuQpttuvkbC3eHF7hY3kTB4fb/gMKwQrZdYHDhd9XvnaVAQW+kq9dWXqnuaRimeFeRGSmvMuOQgk+R7Ixjo3cm6Q4lhtrm0XwMD6D8fCkrjRRCDpgrNguK42ImiFa5EjWaEL5MR2+oQrWUKUqjcQGVfLobGB0VkE/PWd4wRipbwLlz8LXWzGQw73lazEXFTwPaUTyVBeE5vSKK;25:WKX/xpLsDJEkmPe+Ffg/wcovHXEgTnVcXOWn5IUnIAgtUQ/kh5tfIfOU4PEzv8YYjiVPqY0GWV3/D1+pZGvgUSmRI0iXIDpWm9fHBVGSU9UHkJRvE+nuh+LWl5h/GnPD33inKvLdfO6JdZIlbBx5di2UIc057slL57wZQ3MpQUgOlsviixDQUfUyv6SReU7txLsNX80G4A4TDAlNMd3Z9Oyy7+UjoK6i/0qkKRixCsy5mg7IqsS7XM/ZcrCgVx0+OS+Lx+i1oFEGPAGDOtNV4QhvBjywq7GsHP2J8qQSDA1qfch4DhBjsgEdOrj1WIN3Msm9npcJolsFkeD9o8OBCP8Ljd3A1vOtDRldDA5yy/g=;31:zcYtMxSFgMpzebu93QCHgrXTMMNbAifrZ/MuLTHwvmir3qOzYiN/Z6x38ydntodrT0cp9rqpS/0XI3ucApzWGgav4ziuyb51qIkX0nk8c9j0jkHXDpfOQZxhQ2UgRsF80bulsFnkDc7ypDbn2abu6VqS1C3cgrSG0Q0uL3vm5pOCqRw3Fgh1dkE5JbonxP1yMj8+MPJZozmogqqVK1zIchQwoBp3jDLHTAvJAKHaOxo=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0476:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0476;20:30Lfcnw+R8RrLSycnF+DZuMaxYmJm9KOkKh5/bhl9P7nfVuljDH8qu4TvJa743YJ1V+9P58QTVOWlt3VT/p5ihetk5st/sKqBs2Md1Hgxvk08SX+Op1kiSIHkWM9mTwx+FFaN5iKfDmoZ++qG+U+H8JyYUvoPBYjz9deAGXfdOHXhVycXDRLTk7PAzM0CX7c6szvmcEQo586WEQkOdfnmR2+WVXuZQu/MzqN1g2YK4S/aIDAoPLQZVSjnFbNJ92laiQEyD4AyzQLCXEDP2VrMi5fTlRnbMjHyHSjMydGw2rztRHVwqZcXK+RbWhxuGOieSWC2pxcbppteO7i0QWaArBmD1W5K2O4vCM8IAZu34FBYlMTOBHW666WESE85LiWYvZS+y3go18onCaifKrwATImM/MDPBn1m3DtaWI6AIrY8sHWZoEX7YI4kcDnz0u3P/Q+8K/eSq+S3ajQzn4mZa0NnNfzcnPzsQ1AmAKTP6sjpA67YWeGcUz4ixltRfn3;4:XsiJOuvT0cOo514W/z9J1tyiPJCAev07SMSOJ3b2qbnGHznhQyjH66Pe+O4EZ0XmYNoSWbtAW5MzJ4Qk9vfa+VEoMGc6/6pBTuWDadrJRA5Bygh25kjH0b3MOhBDWXG4KcSPqpvL+2bE1uAkNRsxbn3GWy0jERaMK2jll8Bn2Q7haIblv5oay8NkzGe+AqBtfLPpZLch/t9zn2sNz5jQPMdsN9dzVY5lC2+xkcgLt0aTI1mO7NU3PyMwsPARl4Ri7KDl7WCQzEzF79pG/msqIw==
X-Microsoft-Antispam-PRVS: <CY1PR15MB04769180D3C91A339896F9A3D0310@CY1PR15MB0476.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR15MB0476;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0476;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(6246003)(52396003)(7696005)(52116002)(478600001)(25786009)(33656002)(4326008)(50466002)(229853002)(8936002)(316002)(54906003)(16586007)(58126008)(9686003)(486006)(53936002)(55016002)(68736007)(11346002)(1076002)(446003)(476003)(6116002)(46003)(23726003)(105586002)(8676002)(305945005)(106356001)(6666003)(6916009)(81156014)(97736004)(81166006)(5660300001)(2906002)(7736002)(386003)(86362001)(16526019)(76176011)(186003)(93886005)(6506007)(47776003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0476;H:doronrk-mbp.dhcp.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0476;23:m6Oui/FkfZOBjZ85aiODwg6t3XbhCnG0IAe4iVJoq?=
 =?us-ascii?Q?nakj/7C+sL42BqvBTtZDGuxQ9xD48wSqcl5zlYU8b3UI/HpSwErf5XsJSRXN?=
 =?us-ascii?Q?umrAhAUILs78XQ9IqJRkMmp3VRNuh5ZbwvHC5idlAC5mghvgRHa8ZWZWghQd?=
 =?us-ascii?Q?yAcgTckgne83cVm1QNWuW8ibod/wchFgaHRSEUfP/cWC814Z2z0ni1LGBiOq?=
 =?us-ascii?Q?sY+oE3+dVFGDQdf6zcLQKpIC65NWMLur2IjowsBNMGDEZC+vYs5G+ptf7xr1?=
 =?us-ascii?Q?JUaxhg0pHh+ndBf+1Dx5TT++3fvZb65NpJKQhlA+eR/kerUKL6DHLG9Di9OJ?=
 =?us-ascii?Q?mnXVok1913C/FsBFUuEv/5Ifi+Ow4pDmg0fQzz7L9Ne3kt1tYx4xwXY1Od66?=
 =?us-ascii?Q?S4SIOWY3lYNxF0K1UP8Sp38IRzGJE6ZeGwLLiVhEcLIYB6JfrIafe+J1ymS8?=
 =?us-ascii?Q?zE+5rsIoJvSDGw4uUZlCtbB4TqQMUnPMBEkbLOpK4TwSCawtZ9cKOCdVF8sA?=
 =?us-ascii?Q?TQHfjX4gQNF+7nbpCK3VqDW1v9Dc+vGNGo9njQRbt80TiKmb/beQsRBHNVGy?=
 =?us-ascii?Q?ucYn9/kqUrZuN1R2NJUijJd7l7eODYghl9f0ngThElqMdpkHg4Mqeg5EDx7t?=
 =?us-ascii?Q?Ca2t/lxFVoeIo5429vd4Nu2R/4ddP49PCieU6F+bfQec6PnCsQsIWF+ggu2B?=
 =?us-ascii?Q?ibvXIK6YBkpP88PWR8uKZCPQhp8jnAEXLR59In+1b4lNL/IAH9UeFVyVXjrw?=
 =?us-ascii?Q?hfSULq8wv6MYEE59f7IkY86hzNVHq5NAj93ZUQCMosx9se4qk7YhNIIzMiG+?=
 =?us-ascii?Q?jNTxnT2GoPJOU0Xdg4SoRgUfeHtR5nNvbQ3GOkXIceX8kBrDIhrMCqF4unRF?=
 =?us-ascii?Q?ngNB0lXuIe/X8XAlH2d8e9U/jPF+5oGbXwZn0P5KGvD47m/VXmKBiGhShuY4?=
 =?us-ascii?Q?MXrboFrN04M1Igv9wQuNgjCyl94L9eEIN99gBKm/sL/LfIacXHVedZbwHFA2?=
 =?us-ascii?Q?QpPTPomAjY4kuZCHSmiXe3T6eT0Hmt4//nKxXr6LOWlu02VdmnA2E9R9PzIn?=
 =?us-ascii?Q?s4A/qyHBgmaNqjLeaD7OiarhDvNdEbGGpnc+7apQg80e269h96QtIxmXzqe1?=
 =?us-ascii?Q?7X6H3Vv+LVcG+7lHap2HZwDmEDnFECWTkxgskWhTqnXsEQDXh3E1q60aEIrV?=
 =?us-ascii?Q?e/p+zMeu3cYpI746krDf0HhT9NW/KQlsZse101vyZAZm+bAVcujZWzth9etF?=
 =?us-ascii?Q?iB6DioZr9hbj6SqDxw=3D?=
X-Microsoft-Antispam-Message-Info: sauZiOmRPe5oR9b1b4KjoiCgsguEkGZoyk8VULNlPZVrGn3CBLUiiMlJ3hh8e87blNEDByjbisGG4ZGb7ZlJsqAnqqLH1jWEIvBsZvrem65lLc3zS0UO98s3ZCKNPosWDEmHabsS2mwt+1zawgzhm+Fe53G5jo+SVbweRwnerj6yCzhz3ftdIqAbXvQZKji9K4/cyiaACVH+bd9s67IS0Po3S2rdScrIdZvrmxb6mHRzws1EEvbDQHZMaPDI3+iG4Yfyx+K3fBJBMGiVPKYWf8xiUk1lm0MMMa2N/vyUmzeG3X81BnZzLHhoqMe9l0ZmuxlN+ZERuyaQmhTjx6er26v+6FieEX8tA8TH3MotPp8=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0476;6:5grpLWRdrsPik6tD1Q+vQttK4sMjDyWJoN1RivVyj7EEWwnlQIgzrz/Qn+V5wB3pQoH6FgvrNQKz6OCtoF+B8JU5qXJ46B7FXTxNOXTCoC2f8YaTT67ukdXkkp8D3jfiL8KYUabYoiE08MxuhsJkorx7hwS9DvwUQhnKKKoALBR9pvH5PrSnVpc37ObUouxqKSXFlPVt7g24U/m2gNodbpoW4aSxdPZGoD7p452UkI9ATP+tBoCxaSkJRlYuiJGrcBT07duaqupV+e/IMJs4Ta9HL17Sczqzq8h+eh4LW5QdM5cf1wmobwdyqi/RBxpAatiytmiYHabW+3uhgUb8EX9/GB7s84ZuvQX0kvDe9MwmNP7kpjbAJogRWH0gddLeE4inIEYMNOvu8tKZXRooqBYRK6Czx1qP8dZWPVU6rLUBaz9qdxpAHGgVH7JRGwaevpvtD2fTHVHXJ6EmAIFfKA==;5:w5kCeF4ZlnUayVDqhcWIpaOXCE/0Brw/df3LgXL6NFkLn/9B9EMibZzyecRUli9K9QCHf44tOG5Q3UjWHgUlYjMAaB1Mm4IKQ87qRasvODawxcTE2RRBJWZTCYV257BsFveJLaIkPfpA2n78pIpGk6xInUOGvfNOEGiMYXLI1S0=;7:ArmexCHrbwNLFU5Mc8Zq7a0+4yVdrcEfrRe9BKcg3R6NGMcxDzuCZYrEjhMuH7rXCgPbaxRAgG5NY2mrrGJceJehqUjfzX6tOKPQElVIBIrgOsABEETQUlb9Q2cz5ngbroy8JJTYhEovAlsq1Vk1UQXN4TwggUGdZ7WKVxhT5uaC0zbPxLc4nEUX/gSjxA9tsCuEmvg3hJWgKdKizgMM9ylHUxnhGeksFjVifbSSZGcZ4EhaMu0cBc01g5L2W68n
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0476;20:DVP6BvknhHUNk48L8zHibF7HsWy7fmliUi9oDQvnbKyjH2i4Zn3txQlxKFMMcBT4VCDIinp8+DTO+H9Lzxo2iqQhI9TqIIEXNjQN7XomSio9svGCPWkh/o/qyMx8W+X4HGVXEcZDHM3hfC61ReEe1GN1AadHbI1IVy36aA9irn4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 23:35:56.8367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d4e4d6-90ea-482b-62f3-08d607bed83d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0476
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 12:51:13AM +0200, Dominique Martinet wrote:
> That's maybe three more lines than the current patch, which is also
> pretty simple, I'm not sure what you're expecting from alternative
> solutions to call that overly complicated...

The line count is not the source of the complexity. The undue complexity
is having strparser operate in two modes: one for clients that properly
use the API by respecting the value of offset, and another for clients 
that do not. 

> I don't think bpf itself needs to be changed here -- the offset is
> stored in a strparser specific struct so short of such a skb_pull I
> think we'd need to change the type of the bpf function, pass it it the
> extra parameter, and make it a user visible change breaking the kcm
> API... And I have no idea for sockmap but probably something similar.

I'm not sure I follow you here. Any rcv_msg callback implementation
receives an skb. Calling strp_msg() on the skb gives you the strp_msg
which has the offset value. Can you explain why passing an extra
parameter is necessary to get the offset?

> I can't think of that as better than adding a flag to strparser.
> 
> (Also, note that pskb_pull will not copy any data or allocate memory
> unless we're pulling past the end of the skb, which seems pretty
> unlikely in that situation as we should have consumed any fully "eaten"
> skb before getting to a new one here -- so in practice this patch just
> adds a skb->data += offset with safety guards "just in case")

Yes, no data will be copied if the you don't pull beyond the linear
buffer. Adding overhead even in a small percentage of cases still
requires a good justification. In this particular case, I think a good
justification would be demonstrating that it is impractical for the 
buggy strparser users you've pointed out to use the existing API and
respect the value of offset. You have indicated that you are not super
familiar with the bpf code, which is fine (I'm not either), but this
isn't a good reason to make a change to strparser instead of bpf.
