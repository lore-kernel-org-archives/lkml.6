Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA48C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68580208AC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DylGK90J";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RQrpWdrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68580208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbeHAXZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46920 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388730AbeHAXZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:39 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LWcxt016674;
        Wed, 1 Aug 2018 14:37:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=2xbXOpOlhtKpeyTJQEISIkBUhrvHfXf3tGiXyBu5fwU=;
 b=DylGK90JjtB8V8YEZKeCIgGuKYeaLg4uJO+Rij/jw4152if4PjCsunReAkZNBAapN5jk
 AT7RCeQ2dcljGV9k4LtdT+rq2qATmYnlgMcK7sh0kBGJEJtO2OgUN+DZPuGUjNfEZ+QQ
 eZI8nrPH2hNaFteRyMjaFrbIINGE1GN7MZc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkj980faj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 14:37:32 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 17:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xbXOpOlhtKpeyTJQEISIkBUhrvHfXf3tGiXyBu5fwU=;
 b=RQrpWdrtofm0hWx5/3q9mxjuyfObw4FqBcpcr3/KEka3xbwziNMAR4S+YBefITq6G/7tWMdQeEBhFmiae4yYMqE1fqNepzBSg2BpaeR+A9xlfQw0Rvnioa1ytvkQQO97KXoYyXTM6DT0PUc4tfApn3zV2tdGvi/XQab94q9Hvkc=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:18d2) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 21:37:10 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH v5 bpf-next 00/14] bpf: cgroup local storage
Date:   Wed, 1 Aug 2018 14:36:35 -0700
Message-ID: <20180801213649.30751-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:18d2]
X-ClientProxiedBy: MWHPR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:301:73::30) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 818615f5-aed9-4c0b-1adb-08d5f7f6f02c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:OyoBtFsZf7PtdarmcxgGhvshAacFbQ9IoEtbtgjsNccrGG4f1z5iSFIVlFljxRl6/pHJmz2lMfJ+1G1p/jHk0prZhkrayMtRC0QDctj+XvpxiNd1vYuESZX1g3CY0cz80At1YLuFjSpFfrhnT4zXVzDKbpQYgXhGAvdvyBKO2krjkjfecx4/YE23PjcgJB+sSh8OH1MQ+NXzFnqeDfYgALRFN/OkWEoh5QgaHLKq+cxwYFX0RtliTO2qmWvioI9g;25:9nncS+3kT8ut3kDmPdZB0c2/3vvSUgMWhA4tlawOf/dL/uyPXnkjBu4KlSqi9/hsettWZqc2depkUdidw0RjlcOaM0iR6u5z/P7mqKkKkK1Tg3tZWYfxXanvUVHemjNhI84zCxIcmdFqU+aRhUjgG9v08r5TpNP2mfh7KvP872txWef1TJ6glmGF0hvHHEzp86PNpGNuTC07YGpo80jXdan9MkVNqo2SMzULws63O1B1SwRX/pgmcEpHSN5b/ZJ0MbkItRsCLc6hep5hmrgL6T8SvDq7JRAv/4lwxpLsCn9YcZU5AUE5S00rocSziX+nO/EfWjgv/58BDgleNO6k5A==;31:Frq3/Mzq+2XPBapZlkiEf4zukaKWRGMBmDUUtFB1Aaq1k7QmQi0ViDFbpHiSQgURGYJvp1BDVWlixoDVIwaOGO8oUGwpWck0sih2fnuvwOdmjM13XFhPlnEmaedbb6N3lmP8qlkJLvaLTdvd5JsXBAoB40b7dwt+s9YlcjU4+jUzSYQXxbb1TN8rjFzD+E3c4OJgkCWNtWNPTlQ5M9WQfWwQg52ozEmO7NhI+LwsWBs=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:sZ8a4jRiq0TXUxoitoYsXhe6iaQv/ynbGvmzwC7LGN8ig270M3FIQC61KJczPS746IFbQz8mae7QyZFW5d3ZSYAwAA5WBnSuKIFZZ/lLfEM0MbdumKbSd3BwBs2bBgnw7z09xSXORrja/BwcVekHiQsqQ8Blj4kuD8aSGXZSKY6cFS09HzrPXCQ5OapG4/EL+Aa08ho0RSe7DN6yfZ4XAHPuTbP0GHex663pGy1m83Ej2zarIcf7X5YS2s674g7fVLCJRzY95skgDgY0Fl8vIXyNDni78jj3hwGR6ghMPnCmfmbKV7IBQH5bwh5LVrkTCkMEiR7JoXJRwxgkO0FHjNaAqsFfLelh/n7fq4tzaF/tXsdRUy5cRpUXLnD5gomDNOsElCpm34pSWqWPU6ujMHvhgKB1yw6PA0PiSxJV7mWbPnXoZPkOwl2eaJoa/IZYfe8JcUBJV5trdWma8sp4vYiAxLtJ8PhYeznELIWRodtgAqJRo2+g3IhX6JXb5Eu6;4:dFT0HEkdN3fAwEDzfZS92XQUKquMr/EXU620dzvaEANkLdUCGmlYCq0rz6Kz+WM0EF68Uw9P6g4SL4u/rnTSf/1naNd5BiajlWaZyZssAWSGrUtHtgOlI0CEv/U1h6GpfFJANe/X2hezKuttCZwkVA+BuXBdAQ35RG0aLe9s/UiXbjog1oQWYNjC1n9JH6Np0Z6lJF4esnwgWGOhR/0J7vTpUi2tQKITJ0nrq9VyXnRJWTikJUSuvIvWcn7a/BKmHy9//K6fxihzhcnqgyoblXnxeOktIkRSMpvuKze1xlpl/fjtSO73aUV66Bp6A3gJ
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167B2CF0F0CCE1BCDC33843BE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(16586007)(50226002)(68736007)(53936002)(316002)(51416003)(6512007)(6486002)(52396003)(50466002)(5660300001)(6506007)(386003)(4326008)(478600001)(186003)(6916009)(1076002)(8676002)(305945005)(476003)(6116002)(486006)(2351001)(6666003)(7736002)(2361001)(97736004)(8936002)(48376002)(2906002)(16526019)(53416004)(86362001)(47776003)(46003)(5024004)(69596002)(14444005)(106356001)(105586002)(81166006)(2616005)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:G1ScETz4dRn0WommhYGAU4Q9NsJtNuS2U2YofU9a6?=
 =?us-ascii?Q?ShxmGzfXYPcw7Sb0WBqF2D+9kk9wguR8u1Sm5rrG3W4FYkh6oRRfkMfNe8ed?=
 =?us-ascii?Q?Yl4qtaVBKHcd1BHbvk3VjGcbMzCrJBbEBJbDPB7taXKaoqWA/sCvDLv7Xfxi?=
 =?us-ascii?Q?/5BDXxEiCr8RPuw5V0rhyGxV3ur8KqCzlbTE9WSTLZ2Bpxua8BkR0o8+M/H3?=
 =?us-ascii?Q?PfXdAdnpIdYdRZaNytcczpbiGh9gOAX9MpKPTcTKW3wPNWv2qpndhfMK6mM0?=
 =?us-ascii?Q?uVrCEHcDblDqcSkBjUXZ/UK4Ygugw3CVqdKzDZZSC3mR1A0mH0gbMkkML6F9?=
 =?us-ascii?Q?7w5pwb09tSsT4XnU1s9aKNO3jcxoG54lM1TaFahOSkhxrgHR0wqqjKGUPSPI?=
 =?us-ascii?Q?8hzBWFzjQl2xUNhAfGAovBapVUgpB0ERRRnLhEmhTvGgvFF0k78JsjVqL8Or?=
 =?us-ascii?Q?Yg3fPDxM6qFbjWaAUfoHyJwztHXbvjyZPE0qkAfWkYB7hYZ5NUf+SIdlUdzg?=
 =?us-ascii?Q?43Rj5Xv93VUQ2Jm+oy7Yiry0b4uo7ZOWbKTjtroMBMhoNa/3IWMbowTgbMnU?=
 =?us-ascii?Q?l+mm4wt/gpTEZZDBtZwZz3Zw2ho9+aP10qfl6X4o+J9QBmJR+EfmQ6qE3biK?=
 =?us-ascii?Q?b9oSi+TOh/bGv7tisADK0Q8AECOCZhFG0S66rjRoOI7R3tMQM5e5Te2gN1na?=
 =?us-ascii?Q?vHYUCjZ9tGmLgV6nfC7nYaflAyxTI5pT2bRedNxJ3JrN8EYplqUooj2PlETL?=
 =?us-ascii?Q?tOv7Wc93EBTUkES5J3jT+8ciMKi5Tor6NU2nz+zGeh9MOH4Sizj2K8cKO6hi?=
 =?us-ascii?Q?k9VQ/x2I7w8HOf5eukD8JP0w6Yqz7FcvgxQ4zMaG/5YdyL4MbTpnPQB1z+nE?=
 =?us-ascii?Q?lmijmWZtW5FbC8jRac7JLUobRcD9EZX5eTvSjxxbS1uX53oJ8K6A2bNpGX6D?=
 =?us-ascii?Q?VeJXGKpfuIY4JRYhLxQ/bbkSPEBYhGDQRr4ZOa0FbHtGjFC4leuzN/ZQTa5A?=
 =?us-ascii?Q?DR2ky/4Q36UJXxdcV3FnSJVHlWMmWXgJjdqE/2Xre8efstzcFXMmBuKBGOo/?=
 =?us-ascii?Q?ki02ajBvBYY9srAHGOnaV+x3S7D84J1GDvxlhiJKLH9HMRrzDfFqK5yTnj3J?=
 =?us-ascii?Q?pPb0BlNkeKVuy09igIrlivSE/mNf0LyOPGg1BKhly/Ol5TzzsH95silJS/RG?=
 =?us-ascii?Q?B+p3USuT/7bkNZiza9sbGcuz8gR3NS+pD5u7rCaOVFR+3mIuRZ1jOb29/Hkj?=
 =?us-ascii?Q?y1Rug7XfJs+bsLqihQ=3D?=
X-Microsoft-Antispam-Message-Info: s2w1q8PnwDYvaLeWGEPNMzujNqF9G5GR4IK1R9NA/Ys8uCtyY7bzpfUt24zzmbM29TNJOwoKnXh94tINWhFFLZ9Sj/AzGJyjqqEynN5vYuFbsbkHmycOE3gHntZfHAh8cVzA0qux+n9CSilbYp9kVzSqw1zaUa5dS9cJQdOIpB4mZqO3W550KF+ov1YqVo2pV1Ql1yFF/5zrM+v0cxLCD8SzTXo5uT3AkiqrA9Nq77PM/ACS+a6R3sJcZ/gr8vHUetUVv8wv9PX2jL+VnBVjPd/HDLTZ7DFQr598xnM2FLPxLryKDG+mxfytD3HIv4NsZkbDoCCpqhlIQ/hIQQVE0FEV8lkId9rXfcEnqsCpw8g=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:2XTgvVanYcSX9L4qv9HQG86+/cSOkTdccDx0MS+Bu7gA+yRpl34oTMpU3Pca8WFZXbUAGvFt4gsCxwE9qgzSXTOQgV46gVlMDRNB0L5AspjRjK5oEG7FwmG6zX4u5hhE4Iq9svpP0J9Hg+JlpmiWPbAGiR3ozJgdWesLAEDYJo4rOHrp1qp77/mHbjwCpMgEeeol59ssCaEMFkmYlOZm0MYg6POZPgTUdIT/+/waGzwjF+PSJNmopqeHZWEoYky7P04yzTHUBUt7AV3Obwtdt9tCFnRu4Ny3BZ+JbFPnY8IYOZtgYPugGf32/OSOuls44EwP/58yue4XWfg/yxE4SYDPiK4f1iNEZvRkzJQ4Qzet+T3Z1LclcQdBydbH+Dr7HRnFBqNhG+U4g9bIDg0J/MyVnCwCE98H1xdyZyD0rGEDr/eSoyzIn7rTgSIH1Wrejum+A6N+QlCrxnt8d8mrqA==;5:hLaytFARlhLwEy77HYevp8aif3XoDuhD8gGy7HaJuwWu0YfQrOVqYzrC7rOHZSxCbpjHZwr7JIt9bCPkmOFTM447XRmmV0EdUyMuTJUXtJBNCf01C2IuhydUzHCpmlCJnniuamVYA43MSJUPB9BxPS3LBsoHwvfEkbzMjV0qcG0=;7:y8UnQR95Zz3jmXSTK3jCEcFvdGPgcGTh9yBUKIa/GfxREawwLu7KI6l7M+DBtdcqhKf5K+/r4HO73euwnzk1pbTDcDgvUZjAtmTa5tT4jMiNF4RDZrONmgW8AmIKRf24xMf6USGbfAWNbOQLGJaaCKBjTXkqY6btxJkVTPto3gsmi7C52HEdG8LWUkyUcx1ODSS0R/GIU5Ceg1OQP4AZmybPMYJdmyQxvLI91EC1DM7jIm/Dp+YJS8X6n1dhHpCH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:WP6bXaI9yiae2B1KKV/tfit/uYxFMA93PzpZf4MIVFVAUiEZQ2K0EemeTlLiQ4gub+vsqjwI6qKw1NveVHMs6p2a5yQorF2CnI/6223CFdRtLJfBEobzFhYQPIWsELURHMR8thxBF9ZeBILZ1GihM1qoQL0/yvWohFsStD9r8YQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 21:37:10.0355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818615f5-aed9-4c0b-1adb-08d5f7f6f02c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements cgroup local storage for bpf programs.
The main idea is to provide a fast accessible memory for storing
various per-cgroup data, e.g. number of transmitted packets.

Cgroup local storage looks as a special type of map for userspace,
and is accessible using generic bpf maps API for reading and
updating of the data. The (cgroup inode id, attachment type) pair
is used as a map key.

A user can't create new entries or destroy existing entries;
it happens automatically when a user attaches/detaches a bpf program
to a cgroup.

From a bpf program's point of view, cgroup storage is accessible
without lookup using the special get_local_storage() helper function.
It takes a map fd as an argument. It always returns a valid pointer
to the corresponding memory area.
To implement such a lookup-free access a pointer to the cgroup
storage is saved for an attachment of a bpf program to a cgroup,
if required by the program. Before running the program, it's saved
in a special global per-cpu variable, which is accessible from the
get_local_storage() helper.

This patchset implement only cgroup local storage, however the API
is intentionally made extensible to support other local storage types
further: e.g. thread local storage, socket local storage, etc.

Patch (1) adds an ability to charge bpf maps for consuming memory
dynamically.
Patch (2) introduces cgroup storage maps.
Patch (3) implements a mechanism to pass cgroup storage pointer
to a bpf program.
Patch (4) implements allocation/releasing of cgroup local storage
on attaching/detaching of a bpf program to/from a cgroup.
Patch (5) extends bpf_prog_array to store cgroup storage pointers.
Patch (6) introduces BPF_PTR_TO_MAP_VALUE, required to skip
non-necessary NULL-check in bpf programs.
Patch (7) disables creation of maps of cgroup storage maps.
Patch (8) introduces the get_local_storage() helper.
Patch (9) syncs bpf.h to tools/.
Patch (10) adds cgroup storage maps support to bpftool.
Patch (11) adds support for testing programs which are using
cgroup storage without actually attaching them to cgroups.
Patches (12), (13) and (14) are adding necessary tests.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>

v5->v4:
  - fixed an issue in verifier (test that flags == 0 properly)
  - added a corresponding test
  - added a note about synchronization, sync docs to tools/uapi/...
  - switched the cgroup test to use XADD
  - added a check for attr->max_entries to be 0, and atter->max_flags
    to be sane
  - use bpf_uncharge_memlock() in bpf_uncharge_memlock()
  - rebased to bpf-next

v4->v3:
  - fixed a leak in cgroup attachment code (discovered by Daniel)
  - cgroup storage map will be released if the corresponding
    bpf program failed to load by any reason
  - introduced bpf_uncharge_memlock() helper

v3->v2:
  - fixed more build and sparse issues
  - rebased to bpf-next

v2->v1:
  - fixed build issues
  - removed explicit rlimit calls in patch 14
  - rebased to bpf-next

Roman Gushchin (14):
  bpf: add ability to charge bpf maps memory dynamically
  bpf: introduce cgroup storage maps
  bpf: pass a pointer to a cgroup storage using pcpu variable
  bpf: allocate cgroup storage entries on attaching bpf programs
  bpf: extend bpf_prog_array to store pointers to the cgroup storage
  bpf/verifier: introduce BPF_PTR_TO_MAP_VALUE
  bpf: don't allow create maps of cgroup local storages
  bpf: introduce the bpf_get_local_storage() helper function
  bpf: sync bpf.h to tools/
  bpftool: add support for CGROUP_STORAGE maps
  bpf/test_run: support cgroup local storage
  selftests/bpf: add verifier cgroup storage tests
  selftests/bpf: add a cgroup storage test
  samples/bpf: extend test_cgrp2_attach2 test to use cgroup storage

 drivers/media/rc/bpf-lirc.c                       |  10 +-
 include/linux/bpf-cgroup.h                        |  54 ++++
 include/linux/bpf.h                               |  25 +-
 include/linux/bpf_types.h                         |   3 +
 include/uapi/linux/bpf.h                          |  27 +-
 kernel/bpf/Makefile                               |   1 +
 kernel/bpf/cgroup.c                               |  58 +++-
 kernel/bpf/core.c                                 |  77 ++---
 kernel/bpf/helpers.c                              |  20 ++
 kernel/bpf/local_storage.c                        | 377 ++++++++++++++++++++++
 kernel/bpf/map_in_map.c                           |   3 +-
 kernel/bpf/syscall.c                              |  61 +++-
 kernel/bpf/verifier.c                             |  38 ++-
 net/bpf/test_run.c                                |  13 +-
 net/core/filter.c                                 |  23 +-
 samples/bpf/test_cgrp2_attach2.c                  |  21 +-
 tools/bpf/bpftool/map.c                           |   1 +
 tools/include/uapi/linux/bpf.h                    |  27 +-
 tools/testing/selftests/bpf/Makefile              |   3 +-
 tools/testing/selftests/bpf/bpf_helpers.h         |   2 +
 tools/testing/selftests/bpf/test_cgroup_storage.c | 130 ++++++++
 tools/testing/selftests/bpf/test_verifier.c       | 140 +++++++-
 22 files changed, 1028 insertions(+), 86 deletions(-)
 create mode 100644 kernel/bpf/local_storage.c
 create mode 100644 tools/testing/selftests/bpf/test_cgroup_storage.c

-- 
2.14.4

