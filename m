Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56550C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9252156E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kAzPSMGI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kFY4+wAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9252156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeHGW1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:27:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46628 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbeHGW1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:27:25 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w77K4Fmg016248;
        Tue, 7 Aug 2018 13:11:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=74AxbxPh2j0XuzItksfyF2+b2nL+tLuOEhAJOhYRnkc=;
 b=kAzPSMGI8Pbkgs0QX/evKqfpMnOFzXePyri6SxzjmF1vzIelhM/2v0fzgB5vwQxhoHPq
 hjoyLVgXiTH5swreigFnsexEOz7w8ufymPllqJ5ttFamhjPyDdzphGXsdejTn98cpdYz
 8GSEQfOpF+tnFL/rvjkqhQIVCtIKfL4Tei4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kqhrug2y3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 07 Aug 2018 13:11:08 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.27) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 7 Aug 2018 16:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74AxbxPh2j0XuzItksfyF2+b2nL+tLuOEhAJOhYRnkc=;
 b=kFY4+wAexcnkzqiQRVg465R4jejVvclrlgxnLri7vk4pccrjustHePe/YLRlW5bDGMNOvc3HyDyuDkOEVLJflUH59+d1buBMfCyohDB6OimHBv+G4yCfV/B7mh/NIrQ2xEUdnPbOb7mvNiDUMtNY154Hb7szDsv7SrvmWq5V7Qg=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::7:da54) by
 BLUPR15MB0164.namprd15.prod.outlook.com (2a01:111:e400:5249::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Tue, 7 Aug
 2018 20:10:40 +0000
Date:   Tue, 7 Aug 2018 13:10:32 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennisszhou@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2] proc: add percpu populated pages count to meminfo
Message-ID: <20180807201028.GA12087@castle.DHCP.thefacebook.com>
References: <20180807184723.74919-1-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180807184723.74919-1-dennisszhou@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::7:da54]
X-ClientProxiedBy: MWHPR1701CA0012.namprd17.prod.outlook.com
 (2603:10b6:301:14::22) To BLUPR15MB0164.namprd15.prod.outlook.com
 (2a01:111:e400:5249::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e9b75d0-a637-456d-f776-08d5fca1da77
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0164;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;3:sujV1Cr1AH/bYfXPCXUcszK5a6SVcotCMmUQesuIFwJDH31Jyswj7bnO/3MPIXmZ2WDCcAK70WdsiwUF2IybD557GbX86BrMOUqshLB5w9ks7kINgzR4IJDF3wSSkfc1vdtypX3/GebPkM/q7HsS6ugOQx0GOW6Eox+GeNqwZNpWVAteLgAyJOKAMYCHbogpbZKqlTf4k6DopszSi5koXEvhW0U5i2y/usTweP8IpA63I6a52N/2k8hV2+EbaNbU;25:3+FlRLbLbeGoI0gIlLW+C3eW+q3iO9EqEPrneeNIdbac3haZqKR2E39Gkf34UECIcSyc3U8F4fmCKxjLfFbVE7Ts3AtbTDHDtIa1ieKh1Drr0yiRKuXnA88RlVLyKXEwlrSd9mb5ogJSWqkJ6t/fy5rXPQKowcR1Rz8g7Y0htf7MIilPYP8r5i1fq9syyfpHjOkLDrj0G8nROsgkT9eXRu5eLNP7jxirZz3ZeCYvXj/v8+EaXjfjuY8FMKhGMxUVaSixdQqPG7HsKRWhP9lVURuY5l+lIH63Z2PE7UY9gSEqH+FZokRLgfP1STWQzLZrByKlwzRa3cKg76S5XlXGag==;31:G4lnlCkIYY9D9DU6cYXqaqeq9t7oUe2YjTucKT1CTw6fpt8rtVTQkQd0ajaSWwy+9wOkp94pYj24sZ+Ze4py0xhWSa5eTu+9wIG0wBXeqXncTd4aJQZXbkPVWQ6emnz8/1Mb5VuvWaf63S6OQlJ03gEhMwy+jjivVcpaATs3Pq7MC3LCrSMRBx34QSwb79ncj83fpu3mhfOW0biTqWB83bQpdzcN5PasQIEQZmZd9uQ=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0164:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;20:1tt0vq076E/kw165EXvAEExhwb4fSQ9YE9muO5rrkjj40fDz6V18AIRXdgFtiU3yFdkXi5CkI/gr388eOKMYd5L7pjMtAIdnPekertu+9+D936MDL4ipfcB9I9rpQiIePw997qMxacvKRq6rJs56nIWpRb8Bd/iBIF2TUnbaBPH741te7z4h4BLxXt1yle+nZa2vHsX/5DTzRZUdZeIPa5as7Ecax8vRHvLz9BYPDNEcNQHWq1TVsOQXzL8UJo7rTLWlgyMh7At2OHpQbFL05XFa4eQlhxxmAXcD7376WkMDIC/3slcf+NQeezadEAyfyrJOnvBAy9OCNi56o4KONg1tVQm6terQvnLKW+lZVCnzYyUuwtnY+hgfcznRDyRNB3w/UJ0dkdDB620+G3v2niRUFwSOIU+c8xFSUsd813SWMKdQ8Y5ecf9CvnLRXrZxLqFRcysyjnIgPuRhhGAApwrpgtqniRFlfwvDIl5v6UTOgFvAKzAG7Sb5MTjPGZyz;4:jEoB8m6idRnd1/OPvgHEggzxujMvUKBumVswXtKmiqFCURqYenOU7hY2utQBegk46z5wJzZb4nSrmEOdRZPKX0Nf+ABvBIG73ovcsMEzYXEKzvxksjxZsJepgt1C5zo89xrIOCVsQ+NRtkVZOunFkFMjrCiSwqQPKUC+kUZsGEhnizIX41UVoNpbvuosPdCYfvc9A6BZgMODmbYA4CrS5b5BS2+9x34WVvfJSsdKja8XkRNDn00dyCfYPU4XUK0OnAO5CmDrsyOPfiKNM2u9JxWDWDT6NnIP7B7B4ntLP/O2t6ewXESiw3/6A4AXfMGxa5sQhJwg/h4UoHv4O+jEEjnl+Gl57G0reW64BY+eCyM=
X-Microsoft-Antispam-PRVS: <BLUPR15MB01644E045C0EA052E312A1FBBE270@BLUPR15MB0164.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BLUPR15MB0164;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0164;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(136003)(366004)(199004)(189003)(1411001)(14444005)(52396003)(33656002)(54906003)(86362001)(316002)(58126008)(478600001)(68736007)(6246003)(229853002)(486006)(16586007)(9686003)(55016002)(50466002)(53936002)(46003)(23726003)(39060400002)(5660300001)(2906002)(7736002)(305945005)(446003)(8936002)(6666003)(47776003)(81156014)(81166006)(52116002)(6916009)(11346002)(476003)(6506007)(386003)(16526019)(105586002)(106356001)(25786009)(6116002)(76176011)(186003)(7696005)(4326008)(1076002)(97736004)(8676002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0164;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0164;23:k0DhpjoxsaVLeek3r6H6IDC0o0qP/cPDcVi00MBWk?=
 =?us-ascii?Q?4vXizrva95WkOeO6zQJ1OttdThJFCv1lV5WAi+UKLtMnHYdMJbJCyEHCwpx8?=
 =?us-ascii?Q?KsJ5+4+FSxAF/rZPYhp1S5lMprIeG7SWosVuRkQfTbQfOev2RYOLOB7oO/5m?=
 =?us-ascii?Q?4XACtF0N9GL3FNxvcyaWce1ASG9eLAcb37NfZVbQO9IPXP8RaefqNK0yLed4?=
 =?us-ascii?Q?7xZpVNW8ocShaeI6Nx4eVkdpufJy1zAGPg73yCVZUwB9Rtn+9QxKBx5DZtYU?=
 =?us-ascii?Q?cQiLOYOawt5sh6h/T/3lrTIRv6FePQlqvCYzcSDHQusVi+RyIG2eRG7A0vk2?=
 =?us-ascii?Q?rROiG+NB5wbrZg7JzqvLHGzWKMyKZytKXUv858ojSD7ftKL35ROCji5qbkSo?=
 =?us-ascii?Q?ClzNW+i81qWhWefgNDkcic2iEUXFpFZ4rbifQGs9G0KuF8kA8ldlSgr3pJFW?=
 =?us-ascii?Q?5WycJ5Vj0Ylhbkh/MhRWEgiyATEY9OyTMAspOUaLKHTGOzmbiTIRUoMTM9Rs?=
 =?us-ascii?Q?MYCVAngxkgGsw7J/0zXmhD5omOqhtJf4V9Gnetc+BNGu41tes7CiJZd/RGY+?=
 =?us-ascii?Q?TPsBq57B7YcOw1YeJ8WAR7TBYsQnolnLDX3fQx5Zp3y+9AXfpzxllQ2X/HDX?=
 =?us-ascii?Q?NK9gBpGHlHOk/hRra9Y0sUQjdYuCImjEy8Rmp06jQr3rvIZbA5CEG1hvHnkU?=
 =?us-ascii?Q?YIvWfk5w4Vh5Og3s+CrKnwY0Lv9zbghPtxQ1Ah+jgk8CyMcmz/SbgPLUq5S4?=
 =?us-ascii?Q?qVwQkH8h0uKg3rOrgrOtavuXf7UXRTJcW8PZp/ebJk46XRkzgN+dankaGgMz?=
 =?us-ascii?Q?CcUbiMamiiLHWJAkJYjyJ726tr+8nuZbBOX3ljX2idfHN2JzVJp0ijmzJzlI?=
 =?us-ascii?Q?eq1ZbOILA/drhWf6T1lquV80/ZjqNpKr4Dr6ikKXp2ouh0MhGN7fKdwNXRdN?=
 =?us-ascii?Q?pZBW9tgPK3fEaPVhrMNVCvtD3hcRNwbrf8xwHdDjxU8gOIGTlzZA6C/F9Ess?=
 =?us-ascii?Q?rV243WqphzonKXWRCwn1ScK5Hi2wH1Und/hcmoQtI7W/yWhjDtPIE4brkiDx?=
 =?us-ascii?Q?4wxdMsHg1lhUiBDDqTZlnOjJR9pewZgPgtJTFQrXWvuNTWXqQIIuDuGyJHO3?=
 =?us-ascii?Q?nqX1oQ5n4XnCIX38/apBnLFh0twlEjH1lI/G2vgR2VEWiDO2wQkVMpDIN8gX?=
 =?us-ascii?Q?Kpw5cM/41yPBIG+XiQ3Xl/Rm/3USHQxJ6+KJ6em1BAU57Fu3RvkMmEBle1E8?=
 =?us-ascii?Q?8ENBoxHRnq7EMX8ACMyeL0LFpnvCTeNB967ZN69hEDu9F7uUPRTgXusd03yy?=
 =?us-ascii?Q?v+ORutt1Cw5AAsGGzr+gDw=3D?=
X-Microsoft-Antispam-Message-Info: gW80E015X+VrgIJ2EVmlNczFTfSsqNR9kvAC6oGWWwN1WczN68HxwTt0YKAfxWTKAJhS9PdO3h+ODV9U/KNPOoVKLHJJOr4adoORvX6aN4c6ErlGnEoKhMje8LZOGMJysVeOBNVjFrgtcFFkBuXztyK7QLBiFnbdnzDfjKQ+UWfLLorn3pz6UhEXS2QPIe3tBVPL+4amtByDyPr4Ovl17yco9p7LVt1ZAfMPJiCBlBGeJhyZKtEhxiICiyzOSklgTFUdXZNwXcbnTn5ZQ+vmw2Fq7utEGA95qt2c6AIGjo43PRYGmWmb49Tqkt5byknztMcytV8l2obM9Y0gnVALz8qEv6YpqG4ek/hHGN8Zcww=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;6:vk0eSlX6iWkMOlVLgAIVfDvnL3Hzl03D8Qy3Ozoi+ouU+8N9MaDmaXM9j1MM/+aIRa64J+BABRkcWp8ON5Twj/4lNQ+1BFbnFuhAndVYrSs5OuXICTUj5ukOHvlNoiid8yY8VY0S2xglTAM89ha/wCZ8DZ8qjdn4kBDCXoNL/G8wCDcbS+mTu9Yr4oQU7NTiLiTq28KlpoAyjFDqSNyuUhs+KB+M/vz/tZzEVSJe34jjos5kRL+2jkuMX5PpfDSLqT3ISha/5X7i5cIznAuGlI54/uz/Bkav8kJXIQDj16ZmKnCC13JeUruevFO89nsY2AdJS1oadr73Q3IpFdPfmRHV/8vbcMZsM81lTEL2cX5VPh7iyi7ASd5/e/oFME+jiMEBu/1yKE3SKRGR9j0PWeoMS0aokmrUyqYKahyJJ+Gki6ZYwvnB4JoIj/PTPQZEudXURTW7wAyeFUL52CGDZA==;5:F44q/SbVzexWmpOMCcXEGO+EQycwfda41fMk4Ulg1Tk86Q3HTTBtYZHDQbKOOMMnLk+ZPN2muu9UN5HHG8PH5IQqwdVIoCHis8FpU9hM8IpK1qL0U2RwbrxH1OcbspLCFW2nzUeHYrfGMpDMs+Nrw/YiDF+rC+9dsBNNWNrhgOk=;7:JOOs0OUsFFjS9pJsQN4jvPQWcaaCVH3snaThh9GkL7RPuRdnPjAfcAqeXBEeDPffWuETKedbAqEq9CdITcQxV8vB8f9crBAh4skN2/5pohFONHBFGnn7azK4xMvObnJ/2Qm0xgT/3CB6S5AUW6jUxQMS/7jjJRHkkg+ETJNY6x0qoD/onypew0sK5BZ8m4MVjJU380DMxGLSIl9EOSaJykX+FGV/711duB2hciePOh620+I36Eh9En3T3f5PpnsP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;20:q0niv9nlpu54XAkGGzjlszBpNDfJ1zJrNi4iNymb6WApA1eSG+IIlMAn4pTBdaRwxed25cMSOyh/98yYEECp/L27eZQyqO4evr06E7+cU9+2d+lI8fEYetR5T8a48al3F4PWsMk8xL+YO7vssVI/m1NQG1PbNINsMjzb38+OcQI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 20:10:40.1008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9b75d0-a637-456d-f776-08d5fca1da77
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0164
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 11:47:23AM -0700, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> Currently, percpu memory only exposes allocation and utilization
> information via debugfs. This more or less is only really useful for
> understanding the fragmentation and allocation information at a
> per-chunk level with a few global counters. This is also gated behind a
> config. BPF and cgroup, for example, have seen an increase use causing
> increased use of percpu memory. Let's make it easier for someone to
> identify how much memory is being used.
> 
> This patch adds the "Percpu" stat to meminfo to more easily look up how
> much percpu memory is in use. This number includes the cost for all
> allocated backing pages and not just isnight at the a unit, per chunk
> level. Metadata is excluded. I think excluding metadata is fair because
> the backing memory scales with the numbere of cpus and can quickly
> outweigh the metadata. It also makes this calculation light.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Roman Gushchin <guro@fb.com>

It's super useful! I've seen hosts in production which have
tens and hundreds on megabytes in per-cpu memory, and with
vmalloc counters being defined to 0, it's really hard
to notice and track down.

Thanks, Dennis!
