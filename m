Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3E8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE3021527
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KcJH1xid";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aGSzoGlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE3021527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeI1Q1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:27:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53186 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729111AbeI1Q1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:27:03 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w8SA375o020156;
        Fri, 28 Sep 2018 03:03:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=SbgyrQ8jmSpwTIMn8LI+3wEcdGBGSDLwN7ihwM337E8=;
 b=KcJH1xidVjz0Sh2KN0qle0cQk6OKO2ycgWAQ3O31QOQVX210pEJiep62RaBJM3cJEEH4
 G95ayaXq/qtwpvMoJ7BOisk05QrxWSGypXPPzvCS+TaS5GfBLv9z7Ub8u3GB1wiiiRQm
 Co6FmBMEAXXwl6hpRozsJxIwee/zu5UnkD8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2ms9mes7fa-7
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 03:03:49 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.21) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 28 Sep 2018 03:03:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbgyrQ8jmSpwTIMn8LI+3wEcdGBGSDLwN7ihwM337E8=;
 b=aGSzoGlGPXz5w6QHWkJWHNGSfEZeWrTsWv8C0lGudKhp8mSP4je4QvNbgVdJEZuOYM7orZGU63sFnChQvwJVwz3imqcsgaKJ4sJnXvEr0MUC0lS7KKdkuo14NU/3P7W7jIO807Q+/SF1724Z7sERFnoGNyc10pP7YaEUTi4CYCk=
Received: from castle.DHCP.thefacebook.com (2620:10d:c092:180::1:836c) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.20; Fri, 28 Sep
 2018 10:03:14 +0000
Date:   Fri, 28 Sep 2018 11:03:03 +0100
From:   Roman Gushchin <guro@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <netdev@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: introduce per-cpu cgroup local
 storage
Message-ID: <20180928100302.GB9018@castle.DHCP.thefacebook.com>
References: <20180926113326.29069-1-guro@fb.com>
 <20180926113326.29069-4-guro@fb.com>
 <20180928084528.i5txkac34pmqvs3p@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180928084528.i5txkac34pmqvs3p@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c092:180::1:836c]
X-ClientProxiedBy: AM5PR0701CA0006.eurprd07.prod.outlook.com
 (2603:10a6:203:51::16) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03f98db4-5877-4310-de3e-08d625299d65
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:z5sTaJ4yjs3FqzNzrqCb0rRM2/XCIw5W2q3CJJGpUMTndEpuvUI6eEOhf7rYyp1yUxYlTHquinxgM1CUOYgO4utirYJwW34WHH0KY69BU5sWqqGumNoP6gm3k18glSf/n4RGYZibJX7FgKkwuVHLFa3kcDE/s/ZlUr2TUj2IRAsUZa+17VqE6TM8u3lGiqW1uppJ0EwehgGYcfw3NAofQxMmmjdjsi4grKPskOg+K/OuJbVjXwmx+d366h60TdT1;25:97frmqwd+R+Qbl7yxTvBgizdkU5Bi/2vCNeJI1hSJT6zbHVcMdkkr8bsbOMP+AtHNXUNfIdoHvhX4ugxAM0+Hb/zvF/whjhAr/USl7nlQRakccmk/ITdaCc1hzLLRYp5o+FDaOloQDqlr/ZoiCAE3BbaNZO2cBKLFK8u5EZOhu78nW/UMT/rmykjp9Xh2/AYomUzIAsuY69ebvvXMCDWYsEdPg1YVwpS9SdYpnzWaCSFkGg0hqOjzMv17PZHUPNjF7R0PXfQdkvNyum7WpNmXeiDz6ZVXFgNr7xSyrNqVmK7CX8XYQnMW5SbikxT/ceKZK/9SybC+LqKsFgi0wG2PQ==;31:AO4nFw8f0j3zg49VZyks+cz1apVNqODsKrPbpnh2djAcIWk5uQfPjUB5Z+FHyH4NpxlCVeC3NbZxo1H/t3k2S1I4iJaI2erHEi7ULvKPaPpfh8JQ2cetWXwiXX7fFyeRLi/GxpZ+G5vvcbv9pNcQtFQSrDWZvnQe5Ob/FMU94mSdFiazU6FKxFzbaK90HC6GL2jzWMYIVhnmcWz1PN7uJHwVyAinL7aWVewQkoMKe/E=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:nU6L1hGIx7WEMU1DAD+4m8DSBSjdlCQT9ckD9jP+KGUwpf+OFAtX1ie3vOrhTu7Aesd0/TaDBxiu0kaV8PW7+7x1U5qndrepHyRBRPNyV3gAmrIV+3gFwm/PQV/8/TWm88xHbtsgJVF2asirWv/8TFNcz1SelKzcGSh+UdEZQiE7XU7ZT9n75DI/vkA57kIEw9Kc2WgfqGrPBZBGsZ5zEmgijCL3pCAL+l0nl2aY8KcDqUwRggiSuwNEC4TIV0OQbXd3D1OfLnOZwKMkfKWvheOoxwdnQ+EiXKHXA2/ReoHIMhe8U7NYdqjgBhkwvrzvj/o5nWiLIdhkZ2ylE7um3jhY4lnlYUOspY3yOnl+JFfjTMfIxVhImne4ZsUu+zpAmrgvqZoOZWjajyXDk59esKAChsFHXnkrLphdzxodCdlWYaUKYOBlH/U00Z7oQL0hNKcoHCBoEbSIUGuwtcT2XXf4MsK/gd9oomS00yAUqsSfW2egwYB5G2RNZTpNkLMZ;4:gKcONC1cHvsw8kaKNzNhuhORRFsMkiRuJe3zW6kDc+i0SfKh2T2Ni89gY+zQm9dTOYhAKDAyLO9ElowAubzAoESf59+oojqnqlL6jdP2TSEERBOHC20r/bcK4HZvryWy2SnVFlGRlFp69yP4raA6GBDVXL9O+HllDdsx9lzZ3BDyHOtAvtOMXAkulPrlccIDJpA0CuWro5Xf565QUBWF2vc28PWTpuBAxdEE9QOxZKCAc/HJDTRB9myHYVFlKTuXRJ4MouOXgYjTZt5eF0cVCm0xKJYod8YIURnN1gY93jLJHTc8csZBJrQXQ51OWSgi
X-Microsoft-Antispam-PRVS: <BLUPR15MB0162921238376420ED22308FBEEC0@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302061)(3002001)(93006095)(93001095)(10201501046)(3231355)(11241501184)(944501410)(52105095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 0809C12563
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(4326008)(2906002)(105586002)(486006)(97736004)(106356001)(7736002)(476003)(46003)(68736007)(58126008)(5660300001)(6506007)(52396003)(7696005)(16586007)(16526019)(186003)(316002)(54906003)(33656002)(386003)(1076002)(23726003)(11346002)(6116002)(305945005)(52116002)(446003)(76176011)(50466002)(229853002)(47776003)(8676002)(55016002)(53936002)(8936002)(478600001)(9686003)(14444005)(25786009)(86362001)(575784001)(34290500001)(6246003)(81156014)(81166006)(39060400002)(6666003)(6916009)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:KrDo7lAK5CPvrut1wu+WTRQOeItQHGx6ojGaZUNGs?=
 =?us-ascii?Q?V7tXJyxoxIc+beUq93npTrI5amdvvbmGXV0QY641P3Xfz9Rj83ftL2dJoeq2?=
 =?us-ascii?Q?5fbfTjjhtdSRnMV/antgKo5Uzj2BLR58b5QVLdVbxXTAPtRj32rQ35u19tGz?=
 =?us-ascii?Q?+Q+i3cwjwGegT13Tln5HLlxSNrowNp3CskEwcJvS5idQcnpVddIbm/L/t1B6?=
 =?us-ascii?Q?0SV3squEzAF457aeSn0Kf3V1uEvCg2NlqQShvuHUxzgJJH3oNEgWhbvUk/VB?=
 =?us-ascii?Q?ouCrIsSyRzNBUjD3Kwawi4FRhxw3ILzfzLxotVCyW481dAql7Ru9GuNoIaJ2?=
 =?us-ascii?Q?/2lw3svqr5rGt+KSFKgFuu5Iu768Upzq3+yGUAXcpqs6Buqb0njvl8QIcxie?=
 =?us-ascii?Q?wpzgIFJORL6LXlPnzemt5EY0f6MOi735ZcTzYcZVWhE/6CyToR1HqJuAUyqr?=
 =?us-ascii?Q?roZDlcfzIeP4q/XXg1Mj2N1XwNy/WDK0t9tH2UFW1v78zsu9Dqoo0G/kLPgd?=
 =?us-ascii?Q?dx7r4MT2gOFTg8SAdY/xSXSDbg470MF5VsCDMTNeKrE8ar1yioFL1ABlnXGd?=
 =?us-ascii?Q?rfViy/L6gstkw7ML/fjfUSCmXlZKf87OdZjvv1b9vMWmbUYFh0KRDwNjmInX?=
 =?us-ascii?Q?I9MqPNxiAPqLFNHOFwWf8O1NFddb1CNSseecOVX51A9tgZdPj+0tDlSSRATD?=
 =?us-ascii?Q?i3d+y23Y+dus2Io2hHwUmqv4dCg0aE3bamK17+Uh3fSec3c4yuixMidA1MgG?=
 =?us-ascii?Q?e9I/y3ndqs61WJUOzsXxh9gt3QzfuwWWSIeCCUsgLe9EsrrzsnVSen4oILpj?=
 =?us-ascii?Q?eJVImANU8+PZSbgXW7XqEnIilJypa51iDbSKI2a4EeR0Xe3oboweAbcjDepf?=
 =?us-ascii?Q?GsMAeyCXWIgCGA5REbbMIo/HMr/aMFNk8wr3MoLTWLHZkw/VVr+KrkvYyeDS?=
 =?us-ascii?Q?9ALAe07MDgIF1AhzHBIc1HeOC6ncSzReQnZboNIOu8jpS+V+s8LNuA9afmHH?=
 =?us-ascii?Q?94hg6UgvvBaEl50m31DrAEIlWWHBC+WcMaH0dGsyVOmM6lEozlDN7gZddHNV?=
 =?us-ascii?Q?brODSL8+/W/x5IuK2acEayPDrHd32mu+Tiyeo7iEvuNp1MNNEQzXVJsoYosW?=
 =?us-ascii?Q?ojIQTdGzb8Oq0EehmlonoD4iNk6EBHw3u+bnO82UVYXGCvE+tz55uff5N1H4?=
 =?us-ascii?Q?SNxO6HFe+3aPfsu7CF0J+blOSb/qBPKt3Ji7QzG1lYxNegRpS4QVfsKS40ly?=
 =?us-ascii?Q?Pgy8i18hc0nSXYAc3f0Q3l7nIEMbvwl2B2ZSH3il6fIt4pxtRFtQWqocTZm8?=
 =?us-ascii?Q?9MxGhFDHGsLfYPcWiPGT01gkn8JYjyzbMEXVlcqsFan?=
X-Microsoft-Antispam-Message-Info: ifXXEH9/zRGDSpuCo7p9nA1wXVZdPrCrZ16dY9k2LlJYZwiCpbx9O6XIFkZwxXg1vP7hDWUyOLYy+HFQP9+bhDDE+UKiK/3gKYo4O73Fe9egKTx3ZA+szS7A0yKLDMZ2Xx3WrSuRRx0RODUlo3KgLEJaLVYzdvCaFOY66+Ngky/cu/rOqoXZOUc9Q+AOBwhCKwAJd8nUXRjiy1D+ZBMDX5Wun5T3ZHcupy5vMEY8Pvp83sQFIFlY0AMDNP0ieb9SC5iqRuRhhwhA2gJw6qakjimP3UB4MpJvSsxnYtPuDMsViUaiEV9UduOt5++njvJtZdxp8uVuC+i5xol439p5aRcVS/XwehjNxyP6yeiCgfM=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:SWfvnqAAvP8kcqyxrwxhpnJ5rd8DtH57R/huTfCk+5gXQZXOrHy1chnoRJacpdLoB33gu8hsU2utl9iQvnjz+z0BOKOssfNhOfNH2nAy5dn9ZLEtnWA1yJoVdEDah0V3mTW1uhsWVhhZavoC6VtbSOJfYEljMEkCEJccd0Xq0LWf5D1W1jiwLr+AAOwVCp91nUlU6UdZM9ycVHfTXK1pixUsPGUzo1FClqpqZl+3Tr1L8vzyosrfIldOVNVWQVeBXlFS40kpI2SLdA6f8RBlHSlcq8a8mcJJ+mxnfrFd+AfXgPiq/ly4PSqhaTz0AguD4nglsDxaG/z2KW/fJ7kA0Q+RUR2HzBZVHXJkVAb34jPV+Irn8HmJGga8yHUaQM3V4GmcKh4hDLIN6rYF5gHeRf42CYO9E4WBLxLdTxLOJPGpSp2k1jGMcooyhVMYd0aof1W/uxw4kbx0p4eVih+Xtg==;5:FdChOs3bD1Pa4Xoy0cCxWwLWvYkAyqCdg38v48f3Kc+zWqJ41g1yGQuaXnrZZGtCmoiAqhG9v3lbcxdyVG8mNivbYizUDVdOasfF8K6b1yNtaC9qCe8lItJcFmpHOBQuBmMfWou6dAqnNxMCK7wkbGNwbtHHN6r4HFH5f72f+iE=;7:rrCZEJmvbJl91izi2o9flcKFlZYcPOIbAbGdApEznxQ9tCV8rUThfveqFzTcMITgAwKv/G3mV/2Lr0wSQ7Plgdsjg6NV5Renduufa2wZFCSipt/Fln0lusjsVRVWUMuQAZSmKSUYupKPwrkOoEYGLo+gvrUjQ2okZuW4llpR92YAkH/ZV/8P7adwrogidb9ZsXZXwYK+2QDKADx4mQ4yedtKgz6jXvK1GrO8B9T9EJRPBdnu6RXmTfZ2Vs2ugkwV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:v3Xbn8mdxoTqZG3iI1hz2Ln4LLkV9WQucOf5VKkaq6k/XrGU/PyeBAIIz/Rz8Wrg6+IdRU1ldvhnETFCkpRMEcIuuoHiJXKs5c6yiX2lIfZCEHnJCni33uEYmtziFSw8nNy4zZzw/BdVmYOs/V9UHOyiAKN9HlBBdySBiHZC/Xg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 10:03:14.9951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f98db4-5877-4310-de3e-08d625299d65
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0162
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:45:31AM +0200, Alexei Starovoitov wrote:
> On Wed, Sep 26, 2018 at 12:33:19PM +0100, Roman Gushchin wrote:
> > This commit introduced per-cpu cgroup local storage.
> > 
> > Per-cpu cgroup local storage is very similar to simple cgroup storage
> > (let's call it shared), except all the data is per-cpu.
> > 
> > The main goal of per-cpu variant is to implement super fast
> > counters (e.g. packet counters), which don't require neither
> > lookups, neither atomic operations.
> > 
> > From userspace's point of view, accessing a per-cpu cgroup storage
> > is similar to other per-cpu map types (e.g. per-cpu hashmaps and
> > arrays).
> > 
> > Writing to a per-cpu cgroup storage is not atomic, but is performed
> > by copying longs, so some minimal atomicity is here, exactly
> > as with other per-cpu maps.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/bpf-cgroup.h |  20 ++++-
> >  include/linux/bpf.h        |   1 +
> >  include/linux/bpf_types.h  |   1 +
> >  include/uapi/linux/bpf.h   |   1 +
> >  kernel/bpf/helpers.c       |   8 +-
> >  kernel/bpf/local_storage.c | 148 ++++++++++++++++++++++++++++++++-----
> >  kernel/bpf/syscall.c       |  11 ++-
> >  kernel/bpf/verifier.c      |  15 +++-
> >  8 files changed, 177 insertions(+), 28 deletions(-)
> > 
> > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> > index 7e0c9a1d48b7..588dd5f0bd85 100644
> > --- a/include/linux/bpf-cgroup.h
> > +++ b/include/linux/bpf-cgroup.h
> > @@ -37,7 +37,10 @@ struct bpf_storage_buffer {
> >  };
> >  
> >  struct bpf_cgroup_storage {
> > -	struct bpf_storage_buffer *buf;
> > +	union {
> > +		struct bpf_storage_buffer *buf;
> > +		void __percpu *percpu_buf;
> > +	};
> >  	struct bpf_cgroup_storage_map *map;
> >  	struct bpf_cgroup_storage_key key;
> >  	struct list_head list;
> > @@ -109,6 +112,9 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
> >  static inline enum bpf_cgroup_storage_type cgroup_storage_type(
> >  	struct bpf_map *map)
> >  {
> > +	if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
> > +		return BPF_CGROUP_STORAGE_PERCPU;
> > +
> >  	return BPF_CGROUP_STORAGE_SHARED;
> >  }
> >  
> > @@ -131,6 +137,10 @@ void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
> >  int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *map);
> >  void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *map);
> >  
> > +int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
> > +int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
> > +				     void *value, u64 flags);
> > +
> >  /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
> >  #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
> >  ({									      \
> > @@ -285,6 +295,14 @@ static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
> >  	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return 0; }
> >  static inline void bpf_cgroup_storage_free(
> >  	struct bpf_cgroup_storage *storage) {}
> > +static inline int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key,
> > +						 void *value) {
> > +	return 0;
> > +}
> > +static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
> > +					void *key, void *value, u64 flags) {
> > +	return 0;
> > +}
> >  
> >  #define cgroup_bpf_enabled (0)
> >  #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index b457fbe7b70b..018299a595c8 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -274,6 +274,7 @@ struct bpf_prog_offload {
> >  
> >  enum bpf_cgroup_storage_type {
> >  	BPF_CGROUP_STORAGE_SHARED,
> > +	BPF_CGROUP_STORAGE_PERCPU,
> >  	__BPF_CGROUP_STORAGE_MAX
> >  };
> >  
> > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > index c9bd6fb765b0..5432f4c9f50e 100644
> > --- a/include/linux/bpf_types.h
> > +++ b/include/linux/bpf_types.h
> > @@ -43,6 +43,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
> >  #endif
> >  #ifdef CONFIG_CGROUP_BPF
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
> > +BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, cgroup_storage_map_ops)
> >  #endif
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index aa5ccd2385ed..e2070d819e04 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -127,6 +127,7 @@ enum bpf_map_type {
> >  	BPF_MAP_TYPE_SOCKHASH,
> >  	BPF_MAP_TYPE_CGROUP_STORAGE,
> >  	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
> > +	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
> >  };
> >  
> >  enum bpf_prog_type {
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index e42f8789b7ea..6502115e8f55 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -206,10 +206,16 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
> >  	 */
> >  	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
> >  	struct bpf_cgroup_storage *storage;
> > +	void *ptr;
> >  
> >  	storage = this_cpu_read(bpf_cgroup_storage[stype]);
> >  
> > -	return (unsigned long)&READ_ONCE(storage->buf)->data[0];
> > +	if (stype == BPF_CGROUP_STORAGE_SHARED)
> > +		ptr = &READ_ONCE(storage->buf)->data[0];
> > +	else
> > +		ptr = this_cpu_ptr(storage->percpu_buf);
> > +
> > +	return (unsigned long)ptr;
> >  }
> >  
> >  const struct bpf_func_proto bpf_get_local_storage_proto = {
> > diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> > index 6742292fb39e..c739f6dcc3c2 100644
> > --- a/kernel/bpf/local_storage.c
> > +++ b/kernel/bpf/local_storage.c
> > @@ -152,6 +152,71 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
> >  	return 0;
> >  }
> >  
> > +int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *_key,
> > +				   void *value)
> > +{
> > +	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
> > +	struct bpf_cgroup_storage_key *key = _key;
> > +	struct bpf_cgroup_storage *storage;
> > +	int cpu, off = 0;
> > +	u32 size;
> > +
> > +	rcu_read_lock();
> > +	storage = cgroup_storage_lookup(map, key, false);
> > +	if (!storage) {
> > +		rcu_read_unlock();
> > +		return -ENOENT;
> > +	}
> > +
> > +	/* per_cpu areas are zero-filled and bpf programs can only
> > +	 * access 'value_size' of them, so copying rounded areas
> > +	 * will not leak any kernel data
> > +	 */
> > +	size = round_up(_map->value_size, 8);
> > +	for_each_possible_cpu(cpu) {
> > +		bpf_long_memcpy(value + off,
> > +				per_cpu_ptr(storage->percpu_buf, cpu), size);
> > +		off += size;
> > +	}
> > +	rcu_read_unlock();
> > +	return 0;
> > +}
> > +
> > +int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *_key,
> > +				     void *value, u64 map_flags)
> > +{
> > +	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
> > +	struct bpf_cgroup_storage_key *key = _key;
> > +	struct bpf_cgroup_storage *storage;
> > +	int cpu, off = 0;
> > +	u32 size;
> > +
> > +	if (unlikely(map_flags & BPF_EXIST))
> > +		return -EINVAL;
> 
> that should have been BPF_NOEXIST ?

Yeah, or maybe even better s/&/!= ?
It's probably better to require BPF_EXIST flag to update a cgroup storage?
Agree? If so, let me fix this for both shared and per-cpu versions in
a follow-up patch.

> 
> > +
> > +	rcu_read_lock();
> > +	storage = cgroup_storage_lookup(map, key, false);
> > +	if (!storage) {
> > +		rcu_read_unlock();
> > +		return -ENOENT;
> > +	}
> > +
> > +	/* the user space will provide round_up(value_size, 8) bytes that
> > +	 * will be copied into per-cpu area. bpf programs can only access
> > +	 * value_size of it. During lookup the same extra bytes will be
> > +	 * returned or zeros which were zero-filled by percpu_alloc,
> > +	 * so no kernel data leaks possible
> > +	 */
> > +	size = round_up(_map->value_size, 8);
> > +	for_each_possible_cpu(cpu) {
> > +		bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
> > +				value + off, size);
> > +		off += size;
> > +	}
> > +	rcu_read_unlock();
> 
> storage_update and storage_copy look essentially the same
> with the only difference that src/dst swap.
> Would it be possible to combine them ?
> Not sure whether #define template would look better.

I'll try to refactor this and next one in a follow-up patch.

Thanks!
