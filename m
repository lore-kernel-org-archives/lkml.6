Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72328C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F9920866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aclyo1Kf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZD6atUVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F9920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeIKUe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:34:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13635 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbeIKUe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:34:58 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8BFWjFU026049;
        Tue, 11 Sep 2018 08:35:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=sur6dQ7NjzOWHgutXKaafcsjCrT7LvAJSYrNTVAaUGc=;
 b=aclyo1KfoP7hkw3A7LPhxsjxS8SxRRQG36jeWz5aW4X0cO2JfU9yacEEEW/Uux++8hZ4
 Mqw7bfJSWjyd/KJqndY4hSFBdBkQBOGEX2CgS0NYxMkOYIw3LliRi4FruDwHDSrXJ06v
 ebrEehxs8LDwGMoq0AZGsF+ogGMgnB4s7Ho= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mee9hrctj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Sep 2018 08:35:01 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 11 Sep 2018 11:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sur6dQ7NjzOWHgutXKaafcsjCrT7LvAJSYrNTVAaUGc=;
 b=ZD6atUVgkDwZF6fvsWkAuFdk6ZV0eyhadGLwxbSmxTjdryJpN351u4Sb/VYiDifmljSIZQxrXLw1AL0lbhSb6gJWDU22m+d4nncDWeaktIMR4TAVnowbwDYCOzODPaaC80vOvg4zpTlvF/OFZdGZW49sQEkLzfsI1HBstjPU8w4=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::7:f329) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Tue, 11 Sep
 2018 15:34:54 +0000
Date:   Tue, 11 Sep 2018 08:34:48 -0700
From:   Roman Gushchin <guro@fb.com>
To:     peter enderborg <peter.enderborg@sony.com>
CC:     Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RFC] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
Message-ID: <20180911153448.GB28828@tower.DHCP.thefacebook.com>
References: <20180910215622.4428-1-guro@fb.com>
 <20180911121141.GS10951@dhcp22.suse.cz>
 <0ea4cdbd-dc3f-1b66-8a5f-8d67ab0e2bc9@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0ea4cdbd-dc3f-1b66-8a5f-8d67ab0e2bc9@sony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::7:f329]
X-ClientProxiedBy: MWHPR12CA0047.namprd12.prod.outlook.com
 (2603:10b6:301:2::33) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a2061fb-b4a8-4c56-1d54-08d617fc1fe7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:yVpZGpK6A5vsoDQyPOheT+wtAB+2FSV5egC3D+zYyYtOJtAI0qsdC+BTLw7JYLUHFhMyOIP3qqu5qi4PTxAPQEzdCjksA9mBgmeAdTOPeVcJ18/hawIO1fkm4XCtUJAKeCU3+VEUsRZbe4mNnYicyEsQQYXJu/4xgqinyl4JImelU6nb2UhrGI8GJYgfDda1RRKQeby9rNO2SUlEPqfda8Ih7ZBRuxsNir3hj/DNlXpHozEtwJ2zTom2Jg5qBHna;25:Jgm3nBGY9782g0QOpzmLkfgIeIu/6KGU+lLpP7rDTKmRSY4r1bI0G5zqZWmR34kgucgcE9yUxt6Ei6F0xZfZvIX+laYRcUDXTqCCCPHBf5vzL4IcGa/o9/q/lkw60hTIWTV7wwKnPZEyLKEYdeGIR18VrV8yDPOiaWnmxLxOx4yF2y+OK7c7aNAMkI46T8G8mtZmOKaUvH+T7QMjhVnF7PpHi3tU95W0l1d7GezID69CeEkjZQKBHWkhdIC7JLMlAAr/tZiTV3VIzf9pUEpt3qzLmKA1dPEbJJUY+ruu4V98hNXcSnuIAzWiouVI4zuNIwKh9Jeiz2YqdlYPmKsA/A==;31:F9IY8MHuzvU2jyDPtbgQ6bryQTPrEsmKeMLbIE+I/un1Un/S5Z5crafK97Fw+DErUmEKMrni5Aido6bfnj9N+yg6lCelVRN+emgdm3xeNHyHOaE6vxDlRr6VJbzCndzAcsQMvZ155enLGws+DA7o0K0t8tLRp0p3SL8BKwBHja3SrCn+fiuzH6LW4sMuuKAYNroh5M0I0l4VmwaaOa/e8+ykIdeH1cqTWFleL3HCNX4=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:woBu4IwYBQrmqT6qt6XrRi5z3dvP6k7ZbM0/7HtSZOCBSPTTmbDco+g6VK04rb0Lka+P2aNHUFx4Qa9+5Aqi3BCtnuW8gBBTDSs/Xl5YAna6BUaUkEqKcspWUrlHJPLNq6ruBvWTjQuqcdxQLMo8pbVQfruaVQE5q0VetVl1FpI+L75ToNyXW87T7kJqQ3c9GlGKSmy7B/08wgo1w+DwzBiLLb76SB3yb9nOZdDvcz6LSa4txUaSNJN3xtyA3R3qqfUfqjm5ZBjc0osLz281FaQTQfKm2+V+Xsh5uA/w+2MM+UUJyQDRA3C5sNeSICTBTfS/wfmKW9uuJC4VRUfdOstcToQ25P96kRPyLUCNauQEbpf0dLNHESLzDL1TvQyBSyK0fzDW/DGzRIoyJXNKhBTKLndfm/tKPv1nq2T0njFBexY+sxMqfu79TqDWn+VyVwUuWKTZ5xJZ77rmep/BWrLioOP1B/7r6BGomBf3fQHGYlaFXsjA5ZroW3eZieCJ;4:/sTCZoWz82xJY+OBLorgwBiNQ13Rt1jBIMTnvJEdVR1GjNi88uMG2JV5HNVFkc6Bm2Px4WQZoSOIgnOBq0qfhd1ymznnUaVqJl8UfnQrBq69QqObVJB4OE44AE+IWCT4yaW2bzafB5B9z0Sz20Co6e8jrx8ZXc60wGsvNrqOlrfQlo5cv5KKMK40hkjyQDCy2xSOKohB1PatjVp2TV7p4pg9ef3CwUJKox/a4vfjHolb8Wd224bdHgNod6t0mwODFyt2ugtCuguN9QYBTvngtQ==
X-Microsoft-Antispam-PRVS: <BLUPR15MB0162459350022797BB17EC57BE040@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231344)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(25786009)(52116002)(7696005)(52396003)(39060400002)(76176011)(4326008)(6916009)(8936002)(6116002)(478600001)(46003)(5660300001)(305945005)(16526019)(86362001)(229853002)(186003)(6246003)(68736007)(6666003)(14444005)(16586007)(316002)(53936002)(9686003)(106356001)(386003)(105586002)(55016002)(2906002)(58126008)(47776003)(6506007)(33656002)(476003)(53546011)(8676002)(486006)(54906003)(446003)(97736004)(7736002)(81166006)(11346002)(1076002)(81156014)(23726003)(50466002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:EYOSpJ8oHvpxTyPPOWJQ5yOkwVskgGLckE7KPfj7X?=
 =?us-ascii?Q?35Z5NivuoBMCV+5sgDhPVo1uEJ1w+Q3oxbyGBOzaA3QLTPreYHwFVZI0jmdy?=
 =?us-ascii?Q?kaFiULSk1YaOok578AUtcxocrCM4aiixaPobehVFQgKYq51+j8RXE7fbdiN4?=
 =?us-ascii?Q?GOFfgxzs9Nzcg2hb8JzeEgvuBM72cVibeE9S9VBy6AjBPnme1B3n4U97ZMZ+?=
 =?us-ascii?Q?8Ibu2nWlg126mqrDU7r7yUGp3xpC1KVFiVhFjjfdKsElmE2dqMfgWkPkwQld?=
 =?us-ascii?Q?+fMUZ9z2+H2ajOo+JJIz6XgGwKSj6n5PFtpv6I9RU1T5VptxRfB8I5InsP/5?=
 =?us-ascii?Q?YljARFO6zC6B2T7wF7eKTTjD2Xe8Z7/J102IB/5pjtXjLfFQq2MIVepvTnrM?=
 =?us-ascii?Q?jtNWMFeZXqCwyBuZuGSc6AU7HG1fZyfHswqOxCB5SvQTNfvUt1PMp0BRRWip?=
 =?us-ascii?Q?hEqhh4qSivwAPLkzHTZzv6RJiy7OQ0+UfpERDAY4EUbJ5oFawWlXLDfg5m9M?=
 =?us-ascii?Q?8+g7pPgQyxAmGCguH2Kdwllp8+M4qd9PZmFQQS20CFfj3bdORDgj02aSXFmL?=
 =?us-ascii?Q?KeoM9W9EgVafjqK4IDqXKI2XJxxRiV9qR0uvBJmA6kYOwQ/QLVpmDheTjTjS?=
 =?us-ascii?Q?KI8V68y37EtYLVcgVK/L+8hYFopKqpqQTiledHmuawvxY2qF/DypvihMTi5a?=
 =?us-ascii?Q?L4HYmJ/XKmoYD8CECVjkpGD4rOF6nURV5J0i8MEa84ZTNW29zLbQ9umkCyqW?=
 =?us-ascii?Q?hZ9RG0ElVsFsj9gcstHm6NeD14B340BS7AEbQUpXzkUtaMCLSdClcmETv73x?=
 =?us-ascii?Q?p1GI+v6XGDwpryvn6O+ATGwx9Xy5plU8ViqewtKXLos1Uc+cOAFWThjoYgNV?=
 =?us-ascii?Q?ksU9RQmRdOdB5n7+hia+NVR0Xh2VkDgd/Wrxz2ry4+Tdb35I26FwvRnBz7dn?=
 =?us-ascii?Q?ZN0G2Oo9vT2rQyKGp5IFUi4iFvq8O4o+jhCza0R6K8HSxUU9XODu5chCSl49?=
 =?us-ascii?Q?c7tU1iNFDiVKnmVW1SkIN13izuib3oh0gUibYR6rXIJbBPA4Y1qs6mrItj9O?=
 =?us-ascii?Q?DoqAjgrN4BCB2bPuwBmw/cZpwrrkLguOQV9ggxxaHCwtkfxfrWfl203tmP5x?=
 =?us-ascii?Q?rbk0JifltpYXCEJmJZEc1U4ty9/HYoHLZQO/Skn/GLeGl/9WGePWT2LxBaNt?=
 =?us-ascii?Q?PJemXT2uVPGKdJQBwEJo5q413CrUYd11Y7SfcvGa1TNCroCGao/iak2LTR5M?=
 =?us-ascii?Q?7Gq/st0IYLq5fvNLChaKu0HiSx2P9MgSbYGxnmQ2QLMKoctCEg92/iT/knJh?=
 =?us-ascii?Q?iC8qWfSpBwcaV0/B3qn/jw=3D?=
X-Microsoft-Antispam-Message-Info: c6i+72DfBaECkbVq2zoJhD6kFAl+airR6AilL3lgeb0E41PdiH9U+kOF/4DuzjQ8IxSR8vRKNe3nADMER2CsgB6zswTYVj8PuNEzEOv8Amwe7BRJ6XXVXutwBSP8/HDcVynWl6H2iagnhQZigPNRu0DogEZ5wIIRHDHLK5MVw8gUcd+wNaG4PvVKE9q+nFDKLRtYorWASEud9oalazjT4DwdYefbFxw+JiUWejhhVhO4013cX+zLIzS7uwtVbvAvQ4AMWZyVynMFmShCMMuZXIMagtrEl1QWbr4TKNepljyUtagO9ypX1R+Am7pf1z93rch5u363Wb8CEPXA4WRys7jN1VtfRucBZZuR5LkVawY=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:sxnVK09ThV/I7QiCUMtu8OSl4jfBIlShEBMQGKEu8azv0dHNfUkh7GF/6mVeKnfxAhBFCnwRLt4peyPBpeEGkbI4nbzv03gSaQ8PzABbXC3NNrW3We1adN0YkNlrc0TlPku+sa6vClzmWsRR6cF8H23UgOTrUHX9ebubZgKGtu+MFABelQ0ZTvFqInuLfQHXC8u0Yp0IQjGtHzFDPziRRBI7SL5wLdnUqZ4NA2x8oTkFACWvIdw3u4ZZ951sQavwq/vzgl65s70tCOdioohWgVnD6LUzq4n75/3kJIiWD19Gm6hysdY5DTok7af95+txhnNdbKX8Iwgxx3yvgm7QqwF7/2DiNZHcXqnaSjWltcaNpz22ouq4wni8UdkgJj8V2JYL3G6Ilj0zf/FcATQ3p7MFC2A3MmvQ5KfxaHUqIop/+W6Swop/Ev1YAq3gqSdtbcqb0saGwCB5PQe5ljb7aw==;5:T5hhMi2hyZGM6VUq/KtMZOnDvcp3J5zgMidAx5RIXPoX3yUrKd89sOeyuRS/shYxFr8Um2ym41Hbd3JBwzPC+Yc2PZEhdyrU0NCpB7ynKs3+mneF+3MbGPwmn2w/TCLdsCp31Sm34MqbMyH5ziBzwt2ulPxuqgMCSjR9Qgm8tAI=;7:nFBsci7BZQguagsxR/B9l0w7qvdNJjwRPpxp0PoPTCTm/1QciiaCIjikrarfEeL7jCM1i2unUwF1NVlaMdifyQC3sP/5IRAh04WvOrDvEcf59E6ozxr0gObELX5MSigwSfmebw1s68FFupZKgmLYLnA4byp4fhc3GQNbRgiA8fhMPrtKksWz8ZW7yEab6GWvdsUSw+9nhsrUu5tiI9OWcul1PEOgc5CwyNeB2D3TEDFJBHIEuClq1P0AQSAJ75zf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:C6XU8+YfGU99fhSk4z+m3C3uP5YDvZf5TRvxCfyv/cOsyXvcEcr0K0JCd7wruXya9Vqshx/TmUoEd0LQsDSnAFQ0Rw09JEdoXPfOhFGIrNeCwDzG64w2ajMKXSfbwvvi9sHmged/XHDWm5cmI7ze3qn5QloRvO5n8ua1Zyw8zeA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 15:34:54.4722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2061fb-b4a8-4c56-1d54-08d617fc1fe7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0162
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 02:41:04PM +0200, peter enderborg wrote:
> On 09/11/2018 02:11 PM, Michal Hocko wrote:
> > Why is this a problem though? IIRC this event was deliberately placed
> > outside of the oom path because we wanted to count allocation failures
> > and this is also documented that way
> >
> >           oom
> >                 The number of time the cgroup's memory usage was
> >                 reached the limit and allocation was about to fail.
> >
> >                 Depending on context result could be invocation of OOM
> >                 killer and retrying allocation or failing a
> >
> > One could argue that we do not apply the same logic to GFP_NOWAIT
> > requests but in general I would like to see a good reason to change
> > the behavior and if it is really the right thing to do then we need to
> > update the documentation as well.
> >
> 
> Why not introduce a MEMCG_ALLOC_FAIL in to memcg_memory_event?

memory.events contains events which are useful (actionable) for userspace.
E.g. memory.high event may signal that high limit is reached and the workload
is slowing down by forcing into the direct reclaim.

Kernel allocation failure is not a userspace problem, so it's not actionable.
I'd say memory.stat can be a good place for a such counter.

Thanks!
