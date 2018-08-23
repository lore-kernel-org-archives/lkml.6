Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7763AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092B321480
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JHsnugHA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EC87Z29C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092B321480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeHWTyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:54:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50250 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726238AbeHWTyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:54:35 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NGLh21010653;
        Thu, 23 Aug 2018 09:24:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=pEVGDUi/KhIUxL70hlOp/hk1hikBtjLKbwEvJlDMMXM=;
 b=JHsnugHAmMROSaz2h3RmYdKLWAF3IYi4S8ngiimhfaF2Qcm3UpAThamZ5GwBLZiFbhXq
 m0FxVoE3r8kJMNzWma+pU49ZA49rLJv2N2ysEqXpekybIj6atV9oDKVjB2jQFl5e9cBQ
 5DphmdxqOlvEjKcjfSh9GXOZfk4JzTkNAYA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2m1ucds0mq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 23 Aug 2018 09:24:01 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 23 Aug 2018 12:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEVGDUi/KhIUxL70hlOp/hk1hikBtjLKbwEvJlDMMXM=;
 b=EC87Z29CvIkHXibFCKOZEwGCTDE0kV9KPmc37zxR+Uqz9wllcTiUJTmW1qNcPW17ky/1rwClvRzap0TvPedwg26e6YCOA89EswbhECyXHMmqkT5Eu3AC5HzvVwfM8PV+MrhbQXbC1jBe7dtRishJuAwjqb5Ll8BSWz8QCgqBVqQ=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::6:1879) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Thu, 23 Aug
 2018 16:23:56 +0000
Date:   Thu, 23 Aug 2018 09:23:50 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v2 1/3] mm: rework memcg kernel stack accounting
Message-ID: <20180823162347.GA22650@tower.DHCP.thefacebook.com>
References: <20180821213559.14694-1-guro@fb.com>
 <20180822141213.GO29735@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180822141213.GO29735@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::6:1879]
X-ClientProxiedBy: MWHPR2201CA0010.namprd22.prod.outlook.com
 (2603:10b6:301:28::23) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83ed87dd-1ead-4f80-4a81-08d60914d35b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:vRCjlFrTZU/uH5EkGJb35iYMKUGcblF/+piCZBOH3ci3YtujuTpcOhAHmEE3epR6LBeQGyvrUap2bpsfubutQgt8VtpLUwM6OQd6VrSmTUVQU/W0U/XUSLCLqpdj4/klNhgab/cCV/B+Y9CXnwEiKgQwmaov83zzEAcVI8lkRT8vC6KxIwRjh9MTjBGXFTN+k/uC7z2yqq3/Ixo4ErYvOtElkQEayyIxN+scXY6HF8m3gVuDLjn7TB8tmBYUEc+0;25:l39KghxMPDNCxheh2eGnaKOj56Y33EpeMemHRiT2yMA0d6ZdUMPEtVa8Vcqj4mQC02VLaFesu6xRjfD5lPEuIh4P/nGxiJcHWtNR8XKBxwOag/f4JAtS1Q7spboV1TrD3BY/Du+CcYSoGQieeJIIGRlZcovImngkS+6Qvcio6VhNJFp45a77ld1aLYeuijoCH7evvWGvM0+8D9zvOk0dd2BJkssI1ZBilQv22Mi0x8u2617W/yaj6AHFfYqcd1vhkTKKRccTG5pXD4C/AQL6JOeO+dM4EUfKXpoTx1P0MaWWtqm8kCaDp6iSuDPPjhEzmugPrxPw6W+6NW5wCUa7dQ==;31:9ISCE0NzTRIj5TbWNE6EBgDG/DYOUYU/78X5rkr85drKqNmBOq5T3BIxH151/Wh8rH6p2IMiZOyTYtVMrInVg79Hs1jG2FbGa7SeT3YoPfyWtpDZS13EW2vDRg/AjlnA29W1O/zsEzrYckWNWyXkgUKzlCy/pSeKGK+oJOmUtPgdzdFZjh+0dUpkjHzfapAG1uiTCwjDCpPBIOHKRQ+LCsGAnZwza0XQD6Yvg1x2tOM=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:PlvVbY14C2lTpyUYUs+6AUIQQjvWHJoha/X+XECVn+QJaAMfv/FHxyhdgKyTcLneUG5ap1pO2Irdebi7TU1ZrshsRumCgJ+u0UM1TwL8ZN91TKBTrHuCPNGkQTj/fi9pWrmvg/tzUo2U/QyO3rANwwqddIw/n8oa2DerKLa6mW9WxcGeuhVbUoz0ktF7n2FSmzD+Js8AxfRM/eHa1tT/6Y8LD13Ytl6jGkxytTy13hseZlmmaWe/1Q+kcJabEkzZ6uH6shzHqBCk6H+LI5q2PiLd2ZUYDyWMFfRQTcXx2VxJx1iEeoh/uEilrhXCNj2QdUv69zKQKKykpWMlvawrecVzprrhKMAoWJQz03vYnjdllO3yHHMOqX8Ejr6m7Ho4iHTPg3hkGN4LIcQi4ItV9PiGr4+cqNP76MKm+kU3pzJsy8iEUuKYqbtoOZTSV3QaZH6+jtWb4xr5/QhrPPp9y2DErQC5LGBGT67SQrNR+Z99ohARIUICXu5ip9Hz2ZDZ;4:oyXgXHs77t9mU5yL+/A8/wXR4OTtD1UwL/AjSNdYdcIDw99PdcRsqebjKc2Bz/OtoKTNTVOBZExNWHHmj7xNAJX8RDpBpVqrXcUBgcKy34r6199LN13LS5qybErpXTuzzaYxZUD43gFPfqrfHtyCmdvD+ubqqaC94zhDw0ytYoCz+ZFJX6iW/U7BzkxiRpstf8XPR8Wper4E2I7H1SBknf6UCyStmV/CPMH6S+eDH9EBjJH0ROnAPFxc5BvYI59LIg56E0osGc1jkEncKFZRqU8aaOawyI99i0a/Ic9r45M7F0xG/ul/5h9xXK7x82HS7n8uMgWmUWiqKLnQayrAvdb2CgXHu+naluQGklwxD3HrcPkCdqpmS9XCMUEdtp7bfEeS86jm9xr2Ip22phjkrfNh3wrkVPoLnnppozt+WUI=
X-Microsoft-Antispam-PRVS: <SN1PR15MB0175EA5D985DBA6B4498AB99BE370@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(47776003)(53936002)(446003)(76176011)(14444005)(2906002)(52396003)(15650500001)(229853002)(9686003)(55016002)(81156014)(305945005)(86362001)(7736002)(316002)(8676002)(6506007)(386003)(52116002)(81166006)(54906003)(16526019)(486006)(46003)(476003)(11346002)(186003)(7696005)(58126008)(16586007)(25786009)(4326008)(33656002)(478600001)(6246003)(97736004)(8936002)(39060400002)(68736007)(5660300001)(6116002)(1076002)(6916009)(105586002)(50466002)(6666003)(23726003)(106356001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:b1U6fg3ld1f7UPAkKj2XvQeH15pRM05nxs2Ue42Yy?=
 =?us-ascii?Q?aPSftBem09JjJr1HcknMI10D1EHHIXjAc0ob3zJX6LmqLDXnPCtmXDnsZUjb?=
 =?us-ascii?Q?/xHojqDw2RHVxZf1Xv07E5kIXhvAurqlgAxOBnOM/kXdU1FUOzy8yXQoupds?=
 =?us-ascii?Q?ntmvcCBEr/01MW5EPnBTvyD9CLhNrwkQPsKi4Y19UVkf0XDZA4miWEekJaho?=
 =?us-ascii?Q?eQZ/Jtbr0YqQR03yXNKA91fg5yCH6zpHiG7SO6/6uChSplQU22jWPklbNNES?=
 =?us-ascii?Q?kNYxCkwynyubHreuoWDEIKENwZ8kMueIdw1Tc0xZsmOKTfv5Pf6h4aQMEU5L?=
 =?us-ascii?Q?14hZ8HyuoLvhXBqiBb0D4o117VLLShVrqzPROR61AJzGVysilHUPMXKapdl1?=
 =?us-ascii?Q?Q8z9hs+w16apvaBKbWD1a3vtmj5dOJPCurEmL5BpeVPVi2fFkj7BiYqtho0+?=
 =?us-ascii?Q?3z2ZsXjkfeQT8JQO5hQzlh3u9O3P+n2eTPEc/G1worMk71VS7Q6X08oeYjCa?=
 =?us-ascii?Q?uIxlEIoFA53/GsK/++zUqVW+94lKWu24IAdS/XuvNYAMidx2s62kJLFn05iK?=
 =?us-ascii?Q?ZfT2mb3vUkaVaWq/cOcOn7ThQR+Q2Xpv8KzcVEQhnfbPalYtiUJvpcSRTGYi?=
 =?us-ascii?Q?loEYM6I2EvigrCEJeD0gRn1WAvltuGmqwhV3hDH5C8krw+v4B2FZ6V3Q16Z6?=
 =?us-ascii?Q?WQ/JxGkr4QvrUC0XUei7k8i6IwP8X6A8jCHb7HEj84VWiOMAe+97UEx2B6ZQ?=
 =?us-ascii?Q?pot8iXckQAY2NAzoQmhUzPut7BSyB2HdQY4XtgJNyojLnySP6GZqC3NqH7+U?=
 =?us-ascii?Q?7nTKroe2CAsGBH9gBijsdmnX3XcQVIZ7ew+qF9JVx5BuqekPLWclO7O+JXIv?=
 =?us-ascii?Q?3vhm3KlT411JKU1oA7KnC3WaCN4al/rSSZSGODSi5G5gNplfFfAJfWGRutsJ?=
 =?us-ascii?Q?Y8ZO5JdMDekMIymOl9j0wE/cyTjclWhGltSUKKvRrSPuwSHrxJhTarlLXbxy?=
 =?us-ascii?Q?aoxuoKDJhlG76ixPwrHVqNUNgRdnGygvettGDDfaoEZ/6S6Q/I77xhp7b9dn?=
 =?us-ascii?Q?wxiPwN442MVqJhCgUhbzKxgikRajr/ltoOaCVKxayLSFix4BkhCXmCtjsLGq?=
 =?us-ascii?Q?kv6JIJjCzEmzjgMcMJVFQIhp3eeI0tJ/b5coJWe/9v14T20CuAJd4Zkuuc5L?=
 =?us-ascii?Q?o1uSHPbeHPLqbaW6q7specdSyNdhxri5BofPI5yVZ3ByOFVfEciSmAxyaqCz?=
 =?us-ascii?Q?cPGklkn2SsUOpADmdoeonU5SpNKgkU0H7QN9yX1+DkvgwLxumnvwDGh5ufMu?=
 =?us-ascii?Q?FUlNRlhEj7BjkqninVhdFQ=3D?=
X-Microsoft-Antispam-Message-Info: hbutp3V33AXDo64GcwzHs0Mr83tIfSuFULlVlpj0kelEkXZP3ZRMeIgBuTkUf2zawR6iDRSfB1JbXgTk7ILBdEs9KDlzoDhMh8fOe50CulUXW2O1FPiEjynYSHn4oxYSEteO53sAG0uwZTUchDmkfDcSwnPPb2uyy2GFwI84gp/g7KqTSyEoV5YmZCI/WffB5yhT3eB2PnvJELemo1qTybMaAhXeZgThTnhZxqBbaTYxiXDTrzmqVG2sqgRFC1HRjouU92msG9pz5bS6g/Te2SLgfjEolKuLnvZgMox8IT4cFzCcXkGI9IZf6gYaFDvn2oBwR82BwGoKbR3nIlJ+dXKkhDFDvkePNUd+CiCU0Q4=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:k7Lv+h3aF9ne2VuGU3A3ddl8EaHnaYN+558/V41bJWcxeDGV4e9jfI0IBOtCyLCkkSwKq2hWZMUTilcCOtaI1rp0HEUmS8qXMlRgmRs7R6wXd7bPVh/K03D07GmF0kSm7HlD0q3zcBnaS7vXEAvjs0DNDuswRSsNB7wX4oCTyqyfJ9IFOtJpxMGSqKmVQ07jYxINuRxuQXQlXkCE44FxIW+6FMNcJle13M7RowZwuOP35sYD7a726G0Q3L8QtCSuqsTyEbORn1IReqQ44wbgnbZQGNxE2dzJDn2kCkciuOwSFs3kzei+yHXFWWLPBOV6OW4rE3xoG9oRzGIZgg+RVcYZHaHpEa7Jgv1lgQFPlsh03LcFNzd0mKCF8gBom9wK6zzAk1H+WB2suPSZdd0Wong6yjSxlV4sUuEdQIppBCHUC53bsWN1xQo+PamkAMNHA92AdaTnMjvKzm5g8A7z2Q==;5:I5MFe+PNqU62dtncJuPPc75CGRn16BG56D96sG7OqwaYN1DXpqzmQSimPcNdKHK0gUhCO3J+FNqKKVROOiVajSojr/TxWhaxbHld5UIIaiINaW2/FW+4A3RYZWPm7AegDAD95cw4fxKcfdjHXXhpRzBieesW5gP29FhfS1Bcrf4=;7:zFmWgtv5IISjH4o+cARZ1bj/W2/Da/6+tE8j5ibY6lCSJs77ZDVUoJvRp6U7NIWOmKQy56b+uihOKyc+AoLKdopXd3YnQUNmOh0NXi2OKjsZmB4ysGzS2Uu5XVdc9rO6RqgSNWQjcrg2S36y3xcHsVbbPaitjgxO/ulWBR1Caym1tNE/rICtWXZ2WAtS4pFBN379X85ccNZmtm508j7HuRvqRFi2vk3qvlTNG5xCS0CNoo28Ey0O5QZVFeSnKrNp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:E+xIPIs5tuCQ4miIuAHrhe2rMqEa2eA1mCB5nhEaHlliMs/vJfdVVfa/Qcy1T1JBsd7JnB5g7vPPVkz1mrLd9W7XZ9a6Pxa4C9eU3bpQHfy5bXxttiN4zZQWFBA+3JhWNS/FxZkTIXeRlEioPedn9wCENGw/hE1OVhxlKZtT524=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 16:23:56.0568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ed87dd-1ead-4f80-4a81-08d60914d35b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 04:12:13PM +0200, Michal Hocko wrote:
> On Tue 21-08-18 14:35:57, Roman Gushchin wrote:
> > If CONFIG_VMAP_STACK is set, kernel stacks are allocated
> > using __vmalloc_node_range() with __GFP_ACCOUNT. So kernel
> > stack pages are charged against corresponding memory cgroups
> > on allocation and uncharged on releasing them.
> > 
> > The problem is that we do cache kernel stacks in small
> > per-cpu caches and do reuse them for new tasks, which can
> > belong to different memory cgroups.
> > 
> > Each stack page still holds a reference to the original cgroup,
> > so the cgroup can't be released until the vmap area is released.
> > 
> > To make this happen we need more than two subsequent exits
> > without forks in between on the current cpu, which makes it
> > very unlikely to happen. As a result, I saw a significant number
> > of dying cgroups (in theory, up to 2 * number_of_cpu +
> > number_of_tasks), which can't be released even by significant
> > memory pressure.
> > 
> > As a cgroup structure can take a significant amount of memory
> > (first of all, per-cpu data like memcg statistics), it leads
> > to a noticeable waste of memory.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Shakeel Butt <shakeelb@google.com>
> 
> Looks good to me. Two nits below.
> 
> I am not sure stable tree backport is really needed but it would be nice
> to put
> Fixes: ac496bf48d97 ("fork: Optimize task creation by caching two thread stacks per CPU if CONFIG_VMAP_STACK=y")
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Will add, thanks!

> 
> > @@ -248,9 +253,20 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> >  static inline void free_thread_stack(struct task_struct *tsk)
> >  {
> >  #ifdef CONFIG_VMAP_STACK
> > -	if (task_stack_vm_area(tsk)) {
> > +	struct vm_struct *vm = task_stack_vm_area(tsk);
> > +
> > +	if (vm) {
> >  		int i;
> >  
> > +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> > +			mod_memcg_page_state(vm->pages[i],
> > +					     MEMCG_KERNEL_STACK_KB,
> > +					     -(int)(PAGE_SIZE / 1024));
> > +
> > +			memcg_kmem_uncharge(vm->pages[i],
> > +					    compound_order(vm->pages[i]));
> 
> when do we have order > 0 here?

I guess, it's not possible, but hard-coded 1 looked a bit crappy.
Do you think it's better?

> Also I was wondering how come this
> doesn't blow up on partially charged stacks but both
> mod_memcg_page_state and memcg_kmem_uncharge check for page->mem_cgroup
> so this is safe. Maybe a comment would save people from scratching their
> heads.

Ok, will add.

Thank you!
