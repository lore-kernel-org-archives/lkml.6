Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202A4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA92208C1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kREZeJKm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Buari7k1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA92208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeHVVQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:16:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51984 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727466AbeHVVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:16:47 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7MHmn3M006474;
        Wed, 22 Aug 2018 10:50:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=QY+0ukBZrpKSxB6ttQ7vYvacU22OMK+FW7kJfieRl/k=;
 b=kREZeJKm4fYU8jJKaxe/raleksDiHmTJnUVNZm9FDhZU//SCzW2K76OSe0kFgf0Fp2ic
 /8atxfRcjHgzZlEUdBep/YMJOHH51Gz3SB1sBoSMIAxgcLBiwud1qwlrDFc7AB0HpOCA
 LfsowBLVmh1p8ucZFJOdCOmdGYBSvU3Sm0Q= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m1bm2ga0e-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 22 Aug 2018 10:50:26 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 22 Aug 2018 13:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY+0ukBZrpKSxB6ttQ7vYvacU22OMK+FW7kJfieRl/k=;
 b=Buari7k1IS5Zqq4bgzLO2AhqYAeCM295lxb7FluTQXxr4qJUt0BchXygIS5sK4ah1Rw2jrMVR+NEWtseFPlivMMu1CPw3OYojBvfgTPRHxS4I90RISL2WnePXirQteazErX6Nf4Rf0+bXHlnZvi2fZ1eecuVEZSmFBH2WNq1ECI=
Received: from castle (2620:10d:c090:180::1:cf4) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Wed, 22 Aug
 2018 17:50:18 +0000
Date:   Wed, 22 Aug 2018 10:50:12 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Konstantin Khlebnikov <koct9i@gmail.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH RFC] mm: don't miss the last page because of round-off
 error
Message-ID: <20180822175009.GA7807@castle>
References: <20180817231834.15959-1-guro@fb.com>
 <20180818012213.GA14115@bombadil.infradead.org>
 <CALYGNiOf_0fR4R747J11JNROO7_FW_9u16Bg09f+CdWPiFwGvw@mail.gmail.com>
 <20180821171555.GA16545@cmpxchg.org>
 <CALYGNiMO973zcp85i5yd=Fa-Jo7SdObXH6sPuogoO3hnB-GgRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALYGNiMO973zcp85i5yd=Fa-Jo7SdObXH6sPuogoO3hnB-GgRA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:180::1:cf4]
X-ClientProxiedBy: MWHPR22CA0045.namprd22.prod.outlook.com
 (2603:10b6:300:69::31) To BY2PR15MB0166.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc8863de-56f2-4c18-fd2b-08d60857b9bf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:GJQRaFL0qO0kokNAK3BGTMyRknbc7REqXC9FDFew4t024wFPunh7Du8IQ9AA0GyFtPJPlUfRU2vZS+7zhxDxJDRGAsCtpzmXJqoeaJdY5F/5JQJU/Z67MDFLyUurfaJeJgdzS4i0DpzIJUBertLcZ3l9D38odt24KAsB49kx9ZYv4e0zrBHnlMKrS0nSvMQ6ijTl5iD7MD3F3Dqu3PvBNUMEgYGiX/3FE94KKYbwTL82oDyv/6/kFy7rJ2Fec5MA;25:zEQKytjN6uap0cG23KSLnlujvuR2+ElupDULUUYX9X2vzwMQkFIgqJARd2CMlSpOzG4MQGVT9iknjm/ouCV98cRrvuKUZnl4QfRb3zO6abUwNCg6N9ZnCMW/ipeyJG2OhWT5nkTheW14vCfBOQ3SZS+x+48lM5mNyp8K+/ej7+2rB67qQT0siXDebkt7QxxxYw6HGvNgW6vUenG2W1TcQn/ToWA4lHe0CK5GzYyHNoLaz4u/zicLzqoe9zW7uYMaeAb1H7dYGT/+EalEM+4nKYEJE/GQvb/pKcZQ49Q7uF40UniGQixydaun4tukgqFnb9OxfC/vUC3Phtaa7RSkKA==;31:v0UeNdAeCZ4KhOW8wz5Y4usoCHua7NPspeuXH2yx+V0yI//uy+sSG0BG4k1nGh3v6Zfzj3snnHAvBicVdh1WNa5ox/2X9SM8Pp9fIPYoiOYECO4YuWx5tDj8qW3aF0k2/n7+L22DR6mPE7oeGGXOnRykAjKA7/a+c+KYJ1VO4UA3ohdXJRTVVBrjCTElWFDdetJPCN9HPbtV4GMKbsVr6dbGjTzZXt+EkMRH/XTZLI0=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:VdnFIr6CKOTptjE3XFX5b3jkzRA3P/pu5d5EZnRw4PFfmjqwRicStjWrlkuudD7wXHFWaljQH4KAhcAdwrWomye1lodKk5ftKDs9uW8zcv1jWwBmAFOrJXK4gCQ4XFHqXVA/ukSgKAdvgAcXOjaMhugSBcaU+NljtfH2KK8sKIJR0URAPWwpBSXq5V1zSsoNaN8QOSU3gHzxxf9K91UqhT+rSHylEGQFS19mkMYD3NhCsDQyIxhew7nseNc9LIKhvF4qGhEZ3GM9bJd29lRfgp4kakYYHBmLKa2iTa16aHezn+jIKljrQQS3eO0HHh5nxmiggAJg+4BLDCLImVftV+dPVjkfBCns05wlyw2C3jgGQ5aNuhsmgmY9jdWnbpcbDJJoOEIwD2X+cXux58/kOiVrr36ZZNk0KTIE8FX0qJlIEG/e6ELX7ViSZxSWFviEG98GNCEWEivxr9gSY4HvWEXmYbyE5PQBl7gfPbsCpJrdCU5zldf7esmVHJ63BBRN;4:Umm6Ij64eYIWvwaCz7iFeiiVD7NaBe/MEhUsxUhtl0STjuuZBJ3e3EF4cLCCLx/+nazP13Zv6/+KYzX2bdWqWEV81uqu3OJ4afaANh1Kzfn9Qq+gP+a2PkASv7yvjyDnk9C95oJCanZ0W6QfvaMxy/fq+Up95EnvHw9qvy9YVIg2o2thECbtvXeh+peih84TtUtXpxMJfR3rBi1AeCxQSd5QSftvyFyzv2dNRA2xsoDcvxh95vp7qtC6lFhYiPoWJJ2nmBCOyp8qMAtLBSjZUQ==
X-Microsoft-Antispam-PRVS: <BY2PR15MB0166CDA2330740CC3A3D84BCBE300@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(136003)(376002)(39860400002)(189003)(199004)(229853002)(106356001)(446003)(50466002)(11346002)(6916009)(54906003)(105586002)(47776003)(33896004)(6496006)(81156014)(58126008)(81166006)(6666003)(9686003)(7736002)(93886005)(16586007)(5660300001)(316002)(52396003)(76176011)(55016002)(305945005)(52116002)(8676002)(25786009)(46003)(6116002)(6246003)(4326008)(2906002)(53936002)(39060400002)(1411001)(1076002)(478600001)(97736004)(53546011)(23726003)(386003)(33716001)(186003)(16526019)(33656002)(486006)(86362001)(476003)(68736007)(8936002)(18370500001)(32033001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:y11Vm2m3kx8HIxR1LOGo5dFPqhkhyEFjjLpTEa/Tq?=
 =?us-ascii?Q?ANZ/i9S23/PqTg3TTlmbWu1l1muJFeWIJpkhH0CzC8WP9k9qXpWKKDLaGHXu?=
 =?us-ascii?Q?T42Xf0RPdYTc+7/4YFdnzIzsfUTBxnz0sVsJsSe8FjpbRY4EKP16ORgFZMYs?=
 =?us-ascii?Q?zm0p77+WopHhqLTHWmZKLqggxi2wJHSNHNAdNsqVLvZt9B9AdIfWvprcs4ai?=
 =?us-ascii?Q?xI7HbAV9NfOWcfVMFth4m0kde/SsPOm8c1ujgHYBrtp+vfx719qPVM/f4qUP?=
 =?us-ascii?Q?A9F+0YH02Y7EGZlffVH279KJGRPYI1xrEYwT5yIbiMq/tEAHoOIKUAVjLXhQ?=
 =?us-ascii?Q?zFLR8gTC5gaM1DOa/L+CvJRA51axPzDm8qejrtdv7EcrPUuZFuIk6s2fZmfn?=
 =?us-ascii?Q?fT0aXN2MGtTov18u4zAxNL+UNNaULnGgFwNcGZEziB2qG+C0palVC4NASiac?=
 =?us-ascii?Q?AbmDC/0gPNybqhv3vLsWXdVeQECeJBB87IEX6WBJbqPPK0s6Jlq/uYaXBzQA?=
 =?us-ascii?Q?Ta7M3vovheLUi3v+kyO5ay85g6NXhnJgUxJX2+cum1sSX41WMFC3JXXdNBfA?=
 =?us-ascii?Q?ZdwllWc9H2XjzilFfgwGe4GqY5/hM+Y2rZHKJ7uLMkdMd7Po65AhK0gZ2XBw?=
 =?us-ascii?Q?z1J8AFRTXtDnuZlJmZ5VBuV/77iwlU/kxqbUgztZTt+WOq3XOH004P0WYzgO?=
 =?us-ascii?Q?uLMbeh/km9XfIU1YWV+Uvx1e8ozDuswPH9dWEvfBhrsmWpGnA9upGeyDuKSi?=
 =?us-ascii?Q?OICRNQDXN9l0omAKTgla0eA4HEtTnCShB/epp7pyYEd9bMMqtQTowAoumoqm?=
 =?us-ascii?Q?l9SlcwVWikwVZ5ZfeAN+8KITjG9EgXPqxbCOTlCezfLBTJJib7cpa4jQodWU?=
 =?us-ascii?Q?XMlHvLOyY8CnISOfxsEWdebp8xbVjOZieBiKQbU31mMKrambyGgj2LSsnyRi?=
 =?us-ascii?Q?LfZ0zg6PZsJQyMb4/RyWw49slR9JeLQ7mGBy3Dz7ktOmx7Hr5tsPrlBKP5rs?=
 =?us-ascii?Q?TdeFj9T5mcQxd60zFwOMIdZDt17HcAEou14aGjKRqhTTbObrxm0mcwTLjp6E?=
 =?us-ascii?Q?S4i75JupZRDgWMAbxTGXPYWMUAMCqSdJdfiHBbT7ZMNTveNdp1N/I1L3bZWd?=
 =?us-ascii?Q?YQLpgZWB+KFWqsIdxxFmVf1RHHEMij5kr9kqFG70HtIV/ip0b3irLSgc0uM5?=
 =?us-ascii?Q?T3L0VZ3QurSNUn1/kmUgnXsGseDfpwyOL5J8AYAOpHdyZ7+fUT7qeNhxL/Ql?=
 =?us-ascii?Q?KOZUhjNQGOx+BehYGsbEcqGJTDk2P/TutfeRpft3RApjn1oh3BHh8TPZxR4D?=
 =?us-ascii?Q?+pMmlVKv+86cw8aVeFm9Y1H2iDwqBiG73pGxcZRCYYuTBwwQiLRqKI29b+yY?=
 =?us-ascii?Q?jcc3tEyV9RKmv+1hr9uxmpGxx4=3D?=
X-Microsoft-Antispam-Message-Info: Ev/Y9lswBAVVDSqvGEJsuP+wTaNyBFMeivPB7AKx7Rf8mioEkUikxkTHXdf7XraVMDlN0QSeLI15yIQPfrlVnunWg+Ze/GoQ6/xUhrqsiiUw8k5ZGHCNVe8/lOA2DFUt6G3aa7FgxIBDUOQOlHP8WNxnt+tQHr7nydF7Ks0VH3puEj1R/7zZKZijy1W+T0kgcrkWGvUWhjb+4jBtA8yviqchpxPRRwJHtY9CcD25ay2Vh5FadYsarEQ/HGAsE0jFV3cL4c7jnRZ8S2E954wmHFKqJNCb0HfvZd1VXZjDcJ6dfCe1SF+cpPBteFfb+ljFisfymfGvBCYpaHkG2O2Y1SFtXkduLhjfNhmleUvu780=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:stmbxZ4DNO9zIcNEMFFcHM2PeiA3wODdDDAFRFUtWc4m9tIRXfyKk2YJ0PjQ8qAayPNfAlTm7rAZMQXHPYoIquh6s1YXRRA8rLvMRY2KaGdoiqSmsDkA5MRTAlffgq1NIexmnONg7mNwVFywVFZERuhQHGUTUvKwmJ216gRecpa0g5AVcapKMjorqUX/Y2RLjqUQ/i3ZOtDHb8mMkWFMVXXB73sauHchxK9lTn4+OKCw6s9bBa1+J4S5SqmE4nZewBu4KA4oV+73idpk5T3FVK9PsYoPk1mh6bGmJexf8AT+QNJHiOsXWDkqaarYB9jx4RqnxNrlk4L9gNGbO85SzTm6NZ7WAz0XxLv2hFJqwb8AzX/Eys+xaAw6i4FkSbiPzYY6Giy5oaHkifW++mMLDQ+muKIW3zMgnV3Rn11W9opl1p+ZEJeUep5Bzr0Vv69ShX2FwXqN1vws2r2QPaElpQ==;5:rKBk7MCkntIu5h7IZgjA5as7C4VaQT6gu8THNogQW6fNe66y+h4XqB/Wh2RAj30MXaViWRLCbWSs4wzfb0zrXcrvCtyiKR2fxjfkKeGKVxDJD5NVMhcTe18hMnImHlqz5yud+LjqnHbZ+VeqKPJ63CHt+96EjHA4KHRTwrNvWhc=;7:Aj5Y0toHdkpKZL2LN5xaA/AsbMi7rBPmoce0J5wrFqNcowUTLRjuswPkL2JsObK5wM/1xAYEqJL/iKNdF75G8XjmJuN66h53HJhGKvmnNVg7qNzCmgfju81D8f52pVrg/vTpjnKc2CuSZTdaGrSiv9bvHAH2qKpXcxIVyydnRxwkf1rTTxcAHZS7Wuevw2rDypRD/7PQhIXWdpTVOWJiuaUa4M0hwgl9fqsliQGu8zntp9jKbDoY0EhMLkCxjmX5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:ngZp4jKEBmXGgXipt2idipnSg8t0iJb7UaPUV49gd/Fi1mu2i7bZlVFlcf4hzoniH2X9noJbZ396HtnEMt+1rnEs/KQ/omLfwyMSCf5aKDiwiv4a7753ZdLx0wQ2YRNlA6xJcGA9Ur6Kg++N9upzGxVZM/pyNfFqb5ufpaZ0kRE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 17:50:18.2298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8863de-56f2-4c18-fd2b-08d60857b9bf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 09:01:19AM +0300, Konstantin Khlebnikov wrote:
> On Tue, Aug 21, 2018 at 8:15 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Tue, Aug 21, 2018 at 08:11:44AM +0300, Konstantin Khlebnikov wrote:
> >> On Sat, Aug 18, 2018 at 4:22 AM, Matthew Wilcox <willy@infradead.org> wrote:
> >> > On Fri, Aug 17, 2018 at 04:18:34PM -0700, Roman Gushchin wrote:
> >> >> -                     scan = div64_u64(scan * fraction[file],
> >> >> -                                      denominator);
> >> >> +                     if (scan > 1)
> >> >> +                             scan = div64_u64(scan * fraction[file],
> >> >> +                                              denominator);
> >> >
> >> > Wouldn't we be better off doing a div_round_up?  ie:
> >> >
> >> >         scan = div64_u64(scan * fraction[file] + denominator - 1, denominator);
> >> >
> >> > although i'd rather hide that in a new macro in math64.h than opencode it
> >> > here.
> >>
> >> All numbers here should be up to nr_pages * 200 and fit into unsigned long.
> >> I see no reason for u64. If they overflow then u64 wouldn't help either.
> >
> > It is nr_pages * 200 * recent_scanned, where recent_scanned can be up
> > to four times of what's on the LRUs. That can overflow a u32 with even
> > small amounts of memory.
> 
> Ah, this thing is inverted because it aims to proportional reactivation rate
> rather than the proportional pressure to reclaimable pages.
> That's not obvious. I suppose this should be in comment above it.
> 
> Well, at least denominator should fit into unsigned long. So full
> 64/64 division is redundant.

In any case it's not related to the original issue and should be
treated separately. I'd like to keep the patch simple to make
backporting to stable easy.

All refactorings can be done separately, if necessarily.

Thanks!
