Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B34C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A881821502
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OE/pP1K6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KvN8/kNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A881821502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbeHOUTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:19:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33138 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727604AbeHOUTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:19:20 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7FHO70i008878;
        Wed, 15 Aug 2018 10:26:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=facebook;
 bh=cmk9fz4b72B/EW7SSYzDGhKCVMWZtmeWkJvsx2BaEbk=;
 b=OE/pP1K6udAkFGCTZ6lu9GKSmFr7OrOQAzrfJCCjAbzgc1YOznYmIMqpkm8yGy+X3Xvr
 N4Ekl0hs/iVKjJ2Aq+T1NnybbdkS36XV/7Gv7CzCxdCM17PjEu/x/qldCEVIKCdwMB7U
 lqtVYPsYv3zZciI3WRgpdjd98VraeupOSaM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kvp5w0h91-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 15 Aug 2018 10:26:12 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 15 Aug 2018 10:26:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmk9fz4b72B/EW7SSYzDGhKCVMWZtmeWkJvsx2BaEbk=;
 b=KvN8/kNCpkgZuLvuDDuAgmv8zyWoa9BXuQtwh2YxoXpx56fItpZoeLzQsYdr+rT1jq5a+69Kfe46Du3ae2andvPme5/HlL0rP0JLGhQ5HN0s+0q5FtyCOPXTLYzTWJG5nVgt6BLkTFE6iNeLWeD7R+AS62E3lEgBvWMTuz73Lcw=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::5:abf7) by
 BY2PR15MB0168.namprd15.prod.outlook.com (2a01:111:e400:58e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Wed, 15 Aug
 2018 17:26:03 +0000
Date:   Wed, 15 Aug 2018 10:25:58 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 1/2] mm: rework memcg kernel stack accounting
Message-ID: <20180815172557.GC26330@castle.DHCP.thefacebook.com>
References: <20180815003620.15678-1-guro@fb.com>
 <20180815163923.GA28953@cmpxchg.org>
 <20180815165513.GA26330@castle.DHCP.thefacebook.com>
 <2393E780-2B97-4BEE-8374-8E9E5249E5AD@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2393E780-2B97-4BEE-8374-8E9E5249E5AD@amacapital.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::5:abf7]
X-ClientProxiedBy: MWHPR1701CA0024.namprd17.prod.outlook.com
 (2603:10b6:301:14::34) To BY2PR15MB0168.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6cbad61-aa1a-4916-c49d-08d602d42db0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0168;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0168;3:Zcifp63Kd8+ptWWgF2xzr6A0RNXlxtgHBaygiT1nKw9zGf8lUikZ9rL+q8AqCesvmwgiY4yVyouUiwnVlWvNfrPHPt8c1EVMKhpUinJ166kvKZzrvcws1t1vMLUIyaiTUlT/IdQp8+VirD4Wiru5kFukgEfTnFvtmA2KqJcGWVx7ZHhjNdgWrkrZFPCYNnpz8/MhLQOhYsxEbKk1QYEVtED2obBS3p2VP/5StdF6a+VwyenPXfDGJa8nXmfc9hee;25:Q6/5BdrTry326o7K/sADmIhdH9rXzdzbl97JJfDRlfq0J8Ypr5YWu3jYk3GMGRoTNW+fD+ZA9T2AAZyFrwiNTl+B+2IrEUpjhNbYFiM1mITxS+nueUYSTehI0Uy7Kueh8mps3+4Fqv1ELaW9k9ueTTB+SIyRD7dnyLGlT0FlVFBlhksRYwT8wwT6m2ogIt9BD69gYJ7MROZOFrEaWCzdJlF/wttv3wC1ZXKXnLttRyOiFNbGUEjcanwBp5DS+2l/bq4H4Sil7JoXPhEYe3XTwB5rGtZVcrUrH6I/4qoV4BO5VESN02HRSFaA2GuSGhVNklyPNHROrXpiJaDLnH7HEA==;31:SB7A10uQygj0SdRRlGuRDAzR4XSKf6G+ClmOSJbtk7tuVbSjiLVRjwCPdEN7k1B0f/oZttalJBz1VrSaqFvNPswF/ybuUnZVrjZjzZtEvBGayqSwOkU/TLz7qkFhfp3cA8OThqepdfsZ8IJJAtWlMfFLRpWhttOtXnZ4jPB3cGc9yW4F7iwAbJ2zFmUq+EW7H4b/JVoeax6YVj41qLmG7X9S0wXxMtjV3cdyEh9y1JA=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0168:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0168;20:+auBfSYAoWvMPq13aX0whfzulrQkw5wwbcIlAgtqU+4Zsrt/MXN9sbNzwi3uiYRgTSMKwquGB/120oz66K63fifdFl9qqP7diEGOZ93InDOvakyr2j8gWQQSyz5t8g5LqEr9VkWhl116ncI6r4Rnm8zNy/b4qyNo2xT2kHkibtBAl+JXx8H/RW1IaI980qOkngBXj1bl9lELSSMJbaNFPDDHKYLQJx5qXJOxWbUAnY52HDgZOJ87NRhlJKEDHmfi6vR4lzFJorjRMddOfw6qJIUvSyC4cgRIXmwUw+FCUifVcZXYiuWQBoS8CUdLkIlQrRC2+1pqrDHosMteKwaCIQQqOalh/sQ12ciKMR7QrZ45aSJQgKKTxTZ+voG6jk2MUKd1XWFttAZzP5EHtrr2fCgjRDWOrOfVjjSbCJErQS/njH6YtnVBtN8vvMLOKlhN2ox4wGk3Lh3ZfmRc4YKGrlE9p5E85b1nn5vNz86Teiy8Xe4i62NbVC8aPQTvEeXt;4:Yr0zHa/2UCVx85FOAOXe/TH4OwjTrU/WoF0aw9xcgng/NR24Qa1foFhNWaoANhbHp2AgwPkkg+EaxvLP9nI5GCcQSsiBLYoAzrmP4S2/j5Sx8vWvY9D9zLpEjAsb06gzDuKQh0MWUPNpvLBugmKgViNFq8wjOcgFNWS2rd2TlgIwGYbUe3qQJfCJA3HpIdWb27Gnyd+tq6UNKlohUXGLpaeA8JY74x8kH5s9QG92EIdWgy/2btcA67g2Azy5G3+8q+zmyGWC221GHs5JTyoeLeFD1r8DrhJz5sC/iHu05w/wDuAu5v8BN6cPx8sFwBRk
X-Microsoft-Antispam-PRVS: <BY2PR15MB0168A75C2D57E4008DD9BBBDBE3F0@BY2PR15MB0168.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0168;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0168;
X-Forefront-PRVS: 07658B8EA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(346002)(396003)(52314003)(199004)(189003)(4326008)(6506007)(33656002)(9686003)(53546011)(6116002)(1076002)(11346002)(476003)(8936002)(446003)(486006)(55016002)(50466002)(5660300001)(2486003)(105586002)(386003)(23676004)(52146003)(52396003)(46003)(16526019)(39060400002)(229853002)(186003)(7696005)(106356001)(6246003)(478600001)(53936002)(76176011)(52116002)(2906002)(2870700001)(93886005)(25786009)(15650500001)(97736004)(58126008)(54906003)(81156014)(47776003)(305945005)(316002)(7736002)(8676002)(86362001)(68736007)(6916009)(14444005)(217873002)(6666003)(81166006)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0168;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjE1TUIwMTY4OzIzOlRaTXdsRDY4L01Ld3l2RFZ2YWRoZExoU01R?=
 =?utf-8?B?c0gxblJGVnBIS0FWcXNnQnVza3krNHlPN0pNUklpL1IrYTVucDVXaDdLRmVQ?=
 =?utf-8?B?cWxKSkpDRFBCWjVqeEh4cE1FNC9abk9WZzU2VVlqTTY0aUFKSzlhMU5DM01C?=
 =?utf-8?B?STF2UXh1ZGk3SkJ6TEpucm5wdE4xR0JwbUJIM0VwWEFBeFlGT2ZveUphdCsr?=
 =?utf-8?B?RS9JWVZNYkZqKzRDbGxqaFc1LzlMSVZIOVZ6ZE40YWlIZmNmcTZUNXBOYnhH?=
 =?utf-8?B?YlVOZFphMGthKzVKUVErK1hRbzhoTG5MREcvZHFsZUdXVzlkTDBhRE9rU3o3?=
 =?utf-8?B?UTZFM2tEcE9uVmRPb29Bd2pZQ1pRUmJMdUNWSStoK2ZEZUw1NXZ2SFM3Z2Ex?=
 =?utf-8?B?blhyVzkySDRBY0tiZXNqa21EM1MzTU1yRlBUeHgrQ0ViSXNTa3NwNi9OSnhz?=
 =?utf-8?B?Zm1kZlpNVFA1QnByOU8vZWU0SnZ4UmUyRDNOb0hyamhFQnFuVUJGSGExdjd4?=
 =?utf-8?B?SjVkb21KN1FudXZPbHlRbHcrRzhVbHhNOFAzTVY2bnFvSU5SS2VWRkRPNi95?=
 =?utf-8?B?dnVjWXdxT1Blbmd4eW5BVC9MUFNrNUtWUWl2bjU4Zm51TUk0RE1KaGRUNUhv?=
 =?utf-8?B?bHZOUWdqRnFtcGl5U0JESTFGYUFoNW1DU3JPYXNUWStXYWdvcGswQzVLS1hD?=
 =?utf-8?B?c0JvZE1YWkVBMzBWcHYwUGxoYk5XbmxjYXc0R1FPeUVVaWszT2tKYmE5MFR2?=
 =?utf-8?B?NW4zb3BqVHJkbTBwaDFwRXNPL3I4aWtoS3lZZis0NldyazF3bXBaWnZsK1U5?=
 =?utf-8?B?VXh3MWpwTG1QZC9GdEFpZEduMEl5MFp4MEVheFJBcVlkSkN1Z3U2eEFLUktr?=
 =?utf-8?B?YW9IdjVuaUJORXI1V3RHZ2N3blZxek5DNURJUWNZbitSQjlleE5LSlFRUG9i?=
 =?utf-8?B?R0R5dmNHSGFZWE5GYTJiUFp0dCtyTFV4L3IyNTA0VGJyNE9qN3ZKSWYxbk5j?=
 =?utf-8?B?LzZvVURjUEN2WWdSdlN2YVRxNW9QbXJCWTgvTzVXT3QxNEJTWHU1TmNoYnZQ?=
 =?utf-8?B?MElNc25GWVYrMUs2RVB6eTAzVHJSRGZ1T1dJY0o2MytUK05iK0ZnRC9IaGla?=
 =?utf-8?B?bWJGM2NldjhYbk5zQ1lGYnRFbENrTEcxSHh4dW8zcFZRb2tZcC94WFo5ZCtn?=
 =?utf-8?B?NjBrenhOeGpSb0F2RVFsa1AveVNuNE83aDM0blFYYWRKbVdQcHY0RzROSkVV?=
 =?utf-8?B?SFMxZEhHWHBEdHZPdlh6aVFqUm5HR01RT1lDWHFiWFozSk9xK0FhTkJ2WXRJ?=
 =?utf-8?B?eGx2bGc5c1M3S2dkMlFOSVpHd3RMaXZOMWJYWVBLL1Rhb2x1YlEwYmJhYnFh?=
 =?utf-8?B?SHRqMTFINjlUR3JJWDZtTHNQeWRyYnFNUTN6S05YbFhRVjgvYktrSHIyWFJx?=
 =?utf-8?B?SHFuUStsbGZ2cnFFOFlDMHFpeEhWU1RTam5qVTlraTMrODBrVUxtL0kxejkw?=
 =?utf-8?B?d05IY3ljK2RtaDFpWEdrcXJsTkNTbm9lWThWU3F5Q2d5aXdET0l0dFhSRDJ0?=
 =?utf-8?B?K0ErNkl4cjVmaVYyNGZVZGpmNHVEdmFjM1hzY2ZDby9ZbEZFRHhiMjdoTFRa?=
 =?utf-8?B?KzNxeGVSeUNoalNGbk41V1pPdFJkMmkwWWpMQktxNllaQnFFTEhKWnVIM2RJ?=
 =?utf-8?B?UVFLeGVHbjV3c2R6NFRVdHhoYzAyZVdzejA5TGZnVFBSM3VBeWo3bURCL3dt?=
 =?utf-8?B?ekpYNmdPUXMrYThnaGVRT1JBY0JRM2h6Yy8ya3BrdUFyWCtrcTd6WDZtMy96?=
 =?utf-8?B?UjdjTWp4T3BBMEY5WFQ4dTN4OGFDODIrNTBJd0JtTTlDSjltSXYrV1NsQXcy?=
 =?utf-8?B?KzBkVjRTeUgvOUU2OUQ5MGU4WG9XL1ZhTDBPWDZaeExrOWxlQTJNYi9mSFBV?=
 =?utf-8?Q?quq/+9bGEYMnkivygvmGhRiL/6m0vc=3D?=
X-Microsoft-Antispam-Message-Info: HpZfweARIMFZ1lhbjB+5ikY/Z2p951lpIZhOeEhJHAppBY75CXrpC4V9JnuYbwP4j8dUT3TpMlk9GCpXT4347isOxaHhIVKMYEgDp8uqIrxbwGouO5NjLR8OTgHFT1eGUU5ZP1TcBGYZ85mt31Mz30lr8Vm0j/IDi/MjofmcluT4ZwZuRalVmqPZAGte0Artb18xt136fXsXKnzK1cZqd9ILwYVYvOKXyoHoR6GIIZm10eoD4Y3KBcdQ7uXRK0gKg5cTu/SvaTemnAt4TN6Dj+jKpL5N5FAmloSLbrCw+p+VMX4E1klZSyoAS/BPHADfDnu2AnYdIPkrXWdghj6E5ivPGO7a38bOkIySEeGtKH4=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0168;6:j6CVM3slAtMfje5SVpIuuJTyXXKz7guzkxyDuqvcwta7pvt528vPL1Nm0FhCynECIO21tFhmrNBxsmab1oiDILhOj9g1L/+crzCQzOI44daI3nQr5Ev8oOHLEw8TSqP71/Z0TuhnsWem6HtgVuwgX8lUmmi8pdpzWpR6779zPiZ7tV2L77bxjSblGsAxI56dncktOXNSpRYvNaEbwnRXCC8kHpbY3PXEyISSMoHDF96aJ/Ggrw1lB0ejHIY6oQae0grjgmflQ67IBwCjtA4pomCzcle2my4Z6dxcjDPxCF131CEJ7U4uR0ypBvz5e4MgTJq8KSvlNFcbnzSUPc1Nfj4zsjEEftrI+Zs/wUvkE1hEd/b08+VyoXWQJq9etxzXJy9VlC7aBI/jqMT9sB8PyMxrs4aygaE56EpJQkdjeXW+upo+iEi5BN/3uBZWTK5viA9FSiuTgT343kY8PCi9xw==;5:2hJ3V74Edc8Xs9TYmXiosLqFuUu75sxLoeBkO4l/bCNsx0oWKTnvuFG9aJab9fApmWdY4/xf4lVcOvQOc1rAh2RreZPxevhHLo7cSfAVOFuw10mE/Crf5UTxLzJ5fIzd+IN2NJhbWNWOt0/tjLT49VPhdn1YI0H5SuBGrP30eDY=;7:tGwG9hQMAt9W/eVL2AIlJTf7lKyaEYGwMReMOPRtiEvWMIXb7OUxpWSer4IiB+USXWlbfvzGUgMpQBRTcltd04UvCQRKimMuXS/HmEB9jXQb/BX4SPhXL6XhRbUvMcSkGg6X0C9Ae3W0dzQSgG7NqhArzq5CnBpSee49zDevzhfGL37cavNa67W6QH9Ft7cyt2wzqoXx+Nv6vkDrgwZLdrn67kNnNoxoWcmhsQ4ElxmUZB/+kETvsY8Z8nM/quem
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0168;20:GzHuLR0MeW4eNuLEDEHdQrBdqhBu/ULenKoMnyNhBc6aylftfMtZVBuKX4EwrnwUU0MTL9LXIQXh73i4VAUMhiuHPwJYPjnIjbVRvx96D6CQ3i35FepAxG1MhSBzIg/qwVv7PvQmv776yWchpZOeRmRhpNTLpA9CBNY39UUvj1g=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2018 17:26:03.4238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cbad61-aa1a-4916-c49d-08d602d42db0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0168
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-15_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 10:12:42AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Aug 15, 2018, at 9:55 AM, Roman Gushchin <guro@fb.com> wrote:
> > 
> >> On Wed, Aug 15, 2018 at 12:39:23PM -0400, Johannes Weiner wrote:
> >>> On Tue, Aug 14, 2018 at 05:36:19PM -0700, Roman Gushchin wrote:
> >>> @@ -224,9 +224,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> >>>        return s->addr;
> >>>    }
> >>> 
> >>> +    /*
> >>> +     * Allocated stacks are cached and later reused by new threads,
> >>> +     * so memcg accounting is performed manually on assigning/releasing
> >>> +     * stacks to tasks. Drop __GFP_ACCOUNT.
> >>> +     */
> >>>    stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
> >>>                     VMALLOC_START, VMALLOC_END,
> >>> -                     THREADINFO_GFP,
> >>> +                     THREADINFO_GFP & ~__GFP_ACCOUNT,
> >>>                     PAGE_KERNEL,
> >>>                     0, node, __builtin_return_address(0));
> >>> 
> >>> @@ -246,12 +251,41 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> >>> #endif
> >>> }
> >>> 
> >>> +static void memcg_charge_kernel_stack(struct task_struct *tsk)
> >>> +{
> >>> +#ifdef CONFIG_VMAP_STACK
> >>> +    struct vm_struct *vm = task_stack_vm_area(tsk);
> >>> +
> >>> +    if (vm) {
> >>> +        int i;
> >>> +
> >>> +        for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> >>> +            memcg_kmem_charge(vm->pages[i], __GFP_NOFAIL,
> >>> +                      compound_order(vm->pages[i]));
> >>> +
> >>> +        /* All stack pages belong to the same memcg. */
> >>> +        mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> >>> +                     THREAD_SIZE / 1024);
> >>> +    }
> >>> +#endif
> >>> +}
> >> 
> >> Before this change, the memory limit can fail the fork, but afterwards
> >> fork() can grow memory consumption unimpeded by the cgroup settings.
> >> 
> >> Can we continue to use try_charge() here and fail the fork?
> > 
> > We can, but I'm not convinced we should.
> > 
> > Kernel stack is relatively small, and it's already allocated at this point.
> > So IMO exceeding the memcg limit for 1-2 pages isn't worse than
> > adding complexity and handle this case (e.g. uncharge partially
> > charged stack). Do you have an example, when it does matter?
> 
> What bounds it to just a few pages?  Couldn’t there be lots of forks in flight that all hit this path?  It’s unlikely, and there are surely easier DoS vectors, but still.

Because any following memcg-aware allocation will fail.
There is also the pid cgroup controlled which can be used to limit the number
of forks.

Anyway, I'm ok to handle the this case and fail fork,
if you think it does matter.
