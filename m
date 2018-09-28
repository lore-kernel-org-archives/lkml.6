Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EF6C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC962168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="J/9VSUQO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Wfy5z5GO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC962168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbeI1Ty0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:54:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57140 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726068AbeI1Ty0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:54:26 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SDN5eG004101;
        Fri, 28 Sep 2018 06:30:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=fiij2izDBuIU/vUHuYP+UsOVCVQYXlVxv4WK2VqHjjQ=;
 b=J/9VSUQO5xUQ58MQIZi+/lPtwYJwnImrnXbBzdSdaOE3dunjoAWKoEF2/yfp1MqZ0DQa
 L91mU2UogjVmh+c+R6sOzepbwKk8kyap7ffa1iGfRwdIqPZ8y/MLYF7Jd9QKN+UT8+Ze
 C+jSCKnr0NVmU0ksTZs5CWcUba9W5GyJQU8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2msj270js9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 06:30:17 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.18) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 06:30:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiij2izDBuIU/vUHuYP+UsOVCVQYXlVxv4WK2VqHjjQ=;
 b=Wfy5z5GO56inNlK98f4TEWJd2WCK/m2OC6vyQv2DsZz3I3zGgkeYF+6DNbmpmH1J/JVhT6thvrT3k5FyAFnfxNJqQCoBcztpMPySu8aR0xNFB21eyBvS3TbDdYL91zuSKSAyfwQb0nXMMAGoLrWDJNAa8YnLnr4xBIBQ87iiJGE=
Received: from castle.intern (2620:10d:c092:180::1:baa) by
 BY2PR15MB0168.namprd15.prod.outlook.com (2a01:111:e400:58e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Fri, 28 Sep
 2018 13:30:09 +0000
Date:   Fri, 28 Sep 2018 14:29:50 +0100
From:   Roman Gushchin <guro@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: fix flags check in
 bpf_percpu_cgroup_storage_update()
Message-ID: <20180928132944.GA30652@castle.intern>
References: <20180928110648.22973-1-guro@fb.com>
 <c093c1ec-2da4-59ef-4617-f494b48952f0@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c093c1ec-2da4-59ef-4617-f494b48952f0@iogearbox.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c092:180::1:baa]
X-ClientProxiedBy: AM5P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::37) To BY2PR15MB0168.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1528dad-16d3-423f-448a-08d62546842c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0168;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0168;3:vw2ZmPgWg8zTlR5qP/k97pMLsk/6c6Rqwnfj8lmAlgk1E/RxR6hrVyl6Wd6IZc+ml5kEd/qHjZiWGEMvXkXT5nG4oEmIbT5UND7TDs/oAT50UN+VX8WdrZb+OJYyiSqpaY2BGZJG2qv7AwIHgC115j8h9+/jUPCmpo3/rt+RYtHwfh4J/bQ+0GkR9CSKKeGhIaJTorTWQ3ICWTKmgB0jMVIE3WvhL7j96eIj3ARgqwW/sWwlQ9AbZIb7+kD0+Fjt;25:De+hK+wR8E/uc09Q1yS42a9BByFpcHQWFc5FTyzvLoCQYMtzHWFuNqvOOKE4s5xhYOp+Th9P3s8UKFSD7yznu6ANXG/R7DqewpKh+uZIKFcSFCF4L7lSiZaTN4aVt7BiH3kgFv6iMoYVxs+G5R69Lr9UYipDB4JzHm4lN8CHQnhvrHUFtqPb1aSfj2bQNdhsmFgDGtulpS/EkYMpthmiE9JBofV9WODtK7IlXXnDuHU0HmauYRMTb/NcEZHFU7B+Knl0PVTVr+RwTaxhzMpHyqif7e/AkhEqsm9x0LL/EyTWL2ZoQPb6h6SxQP5EvAyO2ZXNtiBgVYu/xXyCMINfsQ==;31:20H9GkzouSvYQ76fR0iylcBqwttXP+/pEEwGXkIJNe3DcIxy+3opK9YrpW2y3mtEmIE6ObXiZ3ToO6a5dcH8Fp7AuwQlHxZGoeYX1SBZHejXfD6xYWiVAuRco6I+hokLPu93myiygfriPhW5OjKNXxB5L5VYs0Ul+JxIKmUtClU7zm4z8fF7cozU1+Xmbov/OuqRMpZYmCvnkCWGM0pVYxS2QbB7Fau6yPMoNqXhycY=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0168:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0168;20:Kv7OtwinmMuStqovJ6TwbjKRhkdFkhB/YWWciGWPkA19uWXWqo9eAdJpHIehitGmi2M4uyHBMNFGZtIVEDQDo5BRMUo04VAlAd5vfa0MP5JsrkpM8K/NZWAk96tpIZ/n/YXv71jf6icNQPkO9DiEfksYZA81J558xuUxuRugx9XHt9+fG6SIomYP0MDWIVN2UCweilNZRNMkaSkfnrBSQa1FHyB0AIlWby+PHn9AsGodWm7bXBf5c4aF+b4YoFI4fWbFcvHrV9uOTn9CoQVYdTE3pj1EfXyavKxwm+ELAVSlAymXD9FQYFP2jvbvbT+CCquHpvqMQQ4pGvopMBIzWPq0f9OaTgFOuj9qzOsobdiWYwfh2adYS++Ob3FlM+9+n8uYmfdWMnlwGuJ/PQVZUtqudyQ5feSI+EeMBJzyTmzcKtIJk/TL8VxmF4Tipcrcz71rQNaURQelNyL2dXor+KSIFEuulTm0QmXyYARVA++8mtujSdnbPvLLm43K/p2T;4:GXNo8rPeRAFmtY6pOX7U4YvxnZ+2anrWSZcOBUy0sZwZo3/TERqLD7XSGrC9CxkfSTRh9BseuEk6h499/VMWUJwJIRPa2CXtyaTNAcxSqv1xW0im6p2tUxSlfdgiTIoXt4MHjkh7pLMh6DUAYB7ygd6T6a7jfdOuWoVAtjisMmzzN1TBrxeXRBirHS/OhOJgRLo9mnjwUfws/QUw+xqle4YQrflM+7xI/NdQNMpRpE4SUSv0A/bQG0jrFzFwFS3E2mIOWHv0cU9buHvRbQBn/z50cHC5kv7PJc6YwkAGsqrAZfkrmciw82eNvWwfCAux
X-Microsoft-Antispam-PRVS: <BY2PR15MB0168551BCEBC45F4124AECD7BEEC0@BY2PR15MB0168.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:BY2PR15MB0168;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0168;
X-Forefront-PRVS: 0809C12563
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(136003)(346002)(396003)(199004)(189003)(86362001)(34290500001)(33656002)(47776003)(81166006)(6116002)(23726003)(81156014)(478600001)(5660300001)(2906002)(6916009)(1076002)(4326008)(7696005)(68736007)(386003)(6506007)(52116002)(53546011)(76176011)(186003)(8936002)(16526019)(5024004)(14444005)(33896004)(25786009)(16586007)(229853002)(97736004)(105586002)(446003)(11346002)(476003)(58126008)(6246003)(316002)(52396003)(55016002)(50466002)(53936002)(9686003)(486006)(305945005)(7736002)(8676002)(46003)(106356001)(6666003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0168;H:castle.intern;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0168;23:0D72oJ88BVjP2kE0vjvV8GoYx5tcwecgAx+gBXohe?=
 =?us-ascii?Q?eeVLH8E2yp8qLdDt8dsRuzrSLfHyWb2/kCkVaBeoIMKtXqw9cCPH5FL7XZVb?=
 =?us-ascii?Q?hJPw8cq78NzHzMrsUAbcmxtBLCPCalXlY2/ZdvU1PLgJ8VpjmbpgDoj22mEd?=
 =?us-ascii?Q?14Sy2f08v0N4dp0xjZIBJLXPW6l0kgCXI38UkQrsfGFL59XB/29kfjjNhbxk?=
 =?us-ascii?Q?I5kJtlv1ktBEJXkGJZvm/vdNeVxFLNBNBsjUJ4SHOdEzNIE5E8+QfgZmOUT8?=
 =?us-ascii?Q?ef8qjeRweAAd7tqPazIRFFOPVsEPJNaKHTy5/PRbNQE8NC+nBMHeCkx2zVsF?=
 =?us-ascii?Q?5XKbxtb2cwYShMkfuMahDyiX/y1YhZcZsSwO3F/lfBjAU/t8IuesVEzEUrUC?=
 =?us-ascii?Q?ghpGAxi8hRIjHvRb3//LQe1aPip+Wn5N4lbXYL5Iz2dxNf1An/NZ68vW8cRK?=
 =?us-ascii?Q?axAi2PwpAHkIp7y2yDlXss1MwpIeoBPIl6cjr3H6/+9flAadIW5p/3E4Eei3?=
 =?us-ascii?Q?QQHTiBVKMO6UzohXap8ZXSb6sci7KymECUcOAyKxwfP5AxL6WtzJRtvyGR0Q?=
 =?us-ascii?Q?+OvTI7sApkW4KOow1gpKtLgeDsPqgA2/NFQAiZBNjtcfW7AT9485lZIOk9Em?=
 =?us-ascii?Q?yjoctTvk9ctsQnS2kExo0LliXyClfN5vfN3BiqZm6c3xiiqUajCHlVjp5mmI?=
 =?us-ascii?Q?hBYCschHBXeSNiw419gOXX/YUKBzLWn9l/WtY2SDiY2gNweq1mBqpGq9CMBZ?=
 =?us-ascii?Q?NllsTxPJSfulDtpVRR8gOpYVRSnrnapist23h30HV7zl9kLZuuxDpz+m67sI?=
 =?us-ascii?Q?5Xq26B6cLCbJsWmFcBdGSQS4Ne9flRj7nQRuxdq7LOZI42E+bEmYYoi2vgvr?=
 =?us-ascii?Q?Mv/CiimbyNaZIhZsuvfFNJJkLHhR70dJVF1CT37hDd25vTBeZwH7kqPLW4JT?=
 =?us-ascii?Q?uJYx8UOhYegB2A8LE/MxzKN4/gVpOF4HvCPVaqjCH4QjyRenkt9f8ocQ0ami?=
 =?us-ascii?Q?SAhzpvAxRU3Wh3YAfLZ6eEuZmlYxsAPCC1+eDnnTNUb2cL+YYw5nmfp5bbO9?=
 =?us-ascii?Q?sTt12o5TGVfaGhOvs+hCRDyckkFb0w7MwvYAu5SdOBqG7r4Q1lMJNwR8l2eH?=
 =?us-ascii?Q?U2N0u36TcvRf6JWToOQvYMWmBG6gksZLkpG8x0W7SgtOJSej5nwNzlU1h3c+?=
 =?us-ascii?Q?Y0rW2kDSRowGyvjYN/1iErWgAAhuXvnyfpmdp89tKDgmrxZsipTDymZGRK0F?=
 =?us-ascii?Q?n0BMG3Kl+Zb/4BMYg2mT+tzOwwfPgSrEm8b3AW6rxvUpPEWKdJH0LgKvT7EM?=
 =?us-ascii?Q?VOy/plNbE0yIsHtZ/F0WhUvlQQ+7OeAwlV1T6Lot1ER?=
X-Microsoft-Antispam-Message-Info: PRCe9NBvx0GO6a7zyIsV3Z6Q4dcRNwSb7I9BdgJC9VbajsVuRKHO5pw8HQuxVBdC2L9sfkCM8cY9StD7SpQaUhzQt8mHkFmp86XQhPBJB2UwNuU7WVZT4Nuv+tfohV4mTMZB2Q9mRWsHWFHUvMOk3GsBezoIqGvI/Pl0VGelYn2T6LMqr5LXfYYr1bMS9HBUIwM6W2UNf8Ytcr5Qbrok5m5sfdBKxwBucGUIKBQmmbPtY4+U6Wlqtmvv0ushGWpUZ+H1cG8P0j2T336ysgx6viNttEbAM8n+qFucVSchj0TkZ/WA0iYUWRfjTL5kQZXXk0XbrXuZrE9O0MlIyl0oUH1dc6NFNKn8eQLQwVgJBz4=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0168;6:1jco3w8LhfgUJvfKRQFenFV0TYoG5n+/xz/zqRszQOxWE2/0qZz5bPzk5w6Hozu/IpiJaOVtXVmvMxm1k21Arblju/IFE8GnzYxKzmEAaI+bmSEn92VvBmtBVEMN/z6eANXVojZ1HPJWI3rzZEoLj7J6hwulUeYGrHK95LhsT/K/mXQPzfPJ8NSLtAOJLzNs+0401YQjFf4vU91Zrr6HTuVtM4d29ZNx2aW5OJFEN+kkvW9GzEw/rVmEDQutcz83mq9PBRUj5TbLLGnVKdHPttfjhbetrbG5mftaXJ1wjkuFtNauKLfwyRPn7RY+J3xKHNG/vLkErtm/gMMS/AoxEoUEUZizamOlWyjWVhPviRdkQPTxlcTRdkUfFTnQi4mXGNOTisablpcxc50uFMhNSdHLWwFieIsLzSaB/fcBDi2N2Ryge9MR6DRNdXUcMB1+U8nfROGl5sKXQkdbj3le+g==;5:P5iP/3gNmcdFGhOMetsJ6GyOtooZt73IE7ezZKOPXhiUjLZDObtvoTQUZ1Jlm1RlwIEjCjisWP1Rc90+04KgVfKWJl9gwPkKVeGXynNTYBKxto59cOhIKdmGDCkLqrzusU4PCsoOysITkr+kP316NSnUw0VY1cWtaqjTR94cQ0E=;7:inRM/v0Oa9opULpfnGicOWFTWwSdSNpt35I0nK/n/jk7HzVtiGh+SaZBxbp6/oOJYbUFRcQPTyIs6rr71G2MwAo5SsJlAkRIwfFDeN1hHSC36H5L0kWHmDG9Z9NcxIM+OzPGKFHVAmTQtsMr6ZlI4YuAhCPiIY62aiV22XwakyT3NB61HhoWhKAYqcPwovm6iOSV8DCTA3ZYS2KAStZucQn9Z1BYlhrh1/nwCpWlUF0RzYre4RDjQLkJ3QqmK/ta
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0168;20:00cuNH7ZItDcV1VqXijdBLOWim6lzloH3GsxmufHPbtPt+wgbxsRxfDwyqPC6eaRkTwoTkfNMIRsM/Uf2YoTjzKXkTUJ2LbnRhdz4ude6x+keJZ3fq+aONNL2Wdo4cpN+gr2ipBIBsyAqfEJyl0fjCU7VA7DpTN4SSSQul5EQTw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 13:30:09.8270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1528dad-16d3-423f-448a-08d62546842c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0168
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 02:11:48PM +0200, Daniel Borkmann wrote:
> On 09/28/2018 01:06 PM, Roman Gushchin wrote:
> > Fix an issue in bpf_percpu_cgroup_storage_update(): it should return
> > -EINVAL on an attempt to pass BPF_NOEXIST rather than BPF_EXIST.
> > 
> > Cgroup local storage is automatically created on attaching of a bpf
> > program to a cgroup, and it can't be done from the userspace.
> > 
> > Fixes: 0daef9b42374 ("bpf: introduce per-cpu cgroup local storage")
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  kernel/bpf/local_storage.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> > index c739f6dcc3c2..190535f6d5e2 100644
> > --- a/kernel/bpf/local_storage.c
> > +++ b/kernel/bpf/local_storage.c
> > @@ -191,7 +191,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *_key,
> >  	int cpu, off = 0;
> >  	u32 size;
> >  
> > -	if (unlikely(map_flags & BPF_EXIST))
> > +	if (map_flags & BPF_NOEXIST)
> >  		return -EINVAL;
> 
> Hmm, this is also incorrect as any future reserved flag would be accepted here and
> couldn't be extended anymore. :/ And it looks like cgroup_storage_update_elem() is
> doing the same today, given the cgroups local storage is still early, we should route
> a patch to stable for fixing this.

Fair enough, will post soon.

> 
> Wrt this series, given the series is top of tree right now, I would prefer a fresh
> respin so we have the fix integrated properly w/o follow-up. Perhaps this could also
> incorporate Alexei's previous cleanup suggestions as well from today if you have a
> chance.

I'm not sure about merging copy() and update() functions, as large #define
blocks are really bad. So I'd think a bit more here. Will do the rest.

Thanks!
