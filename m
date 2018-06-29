Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1160CC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BA227FA5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="baveF1Bn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BRdyecs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BA227FA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966720AbeF2VNK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:13:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52536 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966662AbeF2VNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:13:05 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5TLCMf8002195;
        Fri, 29 Jun 2018 14:12:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=KESKYTmsyD6iJmqFqwBYxYTP21qwjrjjcp48Ao/B9dU=;
 b=baveF1BnXnwjS0IS/dzlHGoIcd9D2kRINiXSX4qJz8W9jkI5szbLPJ/ecvJyxZlPUgqw
 IcNyXlyRlORRR5qmyeBWROEYXSdkSY7064QdmZXum/pHzTjKOW4qjqaB5kZ//fEu9McW
 Gr6BZLJHarE6RvJ/P7zEV02seoX5j1Ze5Ps= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jwv44r1rm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 29 Jun 2018 14:12:21 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 29 Jun 2018 17:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KESKYTmsyD6iJmqFqwBYxYTP21qwjrjjcp48Ao/B9dU=;
 b=BRdyecs2woieO41+VljfwUSUygUGyvEnOiZU27W6TzY2we0NT/zDKqk/1Hn32YtDjz+mZrlQgR52qcAgmEXpUu2kcm/j+vzE+TMbS4xctIn5g7kNfdcZpgNhuRKTU8MFMqDeTgMEWALjB35od432r1P4LWD5juMAOXBMopEOhJM=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::6:26ca) by
 CY1PR15MB0169.namprd15.prod.outlook.com (2a01:111:e400:58bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Fri, 29 Jun
 2018 21:12:11 +0000
Date:   Fri, 29 Jun 2018 14:12:05 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     kbuild test robot <lkp@intel.com>, <kbuild-all@01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-api@vger.kernel.org>, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v2 5/7] mm: rename and change semantics of
 nr_indirectly_reclaimable_bytes
Message-ID: <20180629211201.GA14897@castle.DHCP.thefacebook.com>
References: <20180618091808.4419-6-vbabka@suse.cz>
 <201806201923.mC5ZpigB%fengguang.wu@intel.com>
 <38c6a6e1-c5e0-fd7d-4baf-1f0f09be5094@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <38c6a6e1-c5e0-fd7d-4baf-1f0f09be5094@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::6:26ca]
X-ClientProxiedBy: MWHPR1701CA0011.namprd17.prod.outlook.com
 (2603:10b6:301:14::21) To CY1PR15MB0169.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91e0f3ed-06fb-4122-8a23-08d5de04fbe3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0169;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;3:ao3I7C0Hho4XfJOrzmj1aOs/JbEUOSpnbfqsToUqPlTlySd7xGd4arg9hfK+1a9ezR1fElqHqL0dlyxt7h9QSx/driwEg2Yk3rUheYKsz27gBMjsXvry9kodZ32f9CIgPrpNJSOzAaBd+Rpbj2iazUBRW9b7ZAT+CdSeZoDVd/oVvQ0IU24VKR4NaVcv4xQydHCqdJAdhzphTY7+rX1wpHM/UvFadca+5+1ftGWrKfbM1VdNNErvw2/HgaBnlDWJ;25:Va/3trqwMNnRnDVd7YTml9wXx/phS/pO5qpDq445T2qoM2Gdkq4DrJ92UZzIAKlyss4flHTHwEK9NKfMig2l908eh5pJb6vVo2qmw2uxssb40LgPodyudf+pdZKkcgdV8F4YalG73VyeHyFP2Ka/wxviantyCd72dFQ6iXVGgQVV8l8j8TeC8+POP+DmwGpWd1rX8dnNzGHoCjz2hvoALdHCZkPsnULcHxZFM/K+to6OWqAhgOZdLUR4h73hlAtN5ck11CQJVORPFnufOZpHydUSqkclQ+21/WzBdhwLbSRlFtcz+/W1ytMlLVgUY5vqxyjAQc7lgvtxDWB+wIQucQ==;31:R1oICjoXGmIli6FZAnFof0CP1eEIBOWcAAf5m2QR2sKWt1fAVIdRECBMpAV81Vfn1Tcxm9/8AQvxlAq4pZEuwnzSPwhhW6AMT3oez7s8vzdxg9iI7fhYAo6+9w0yfLLOjblgyQMpAYZUlHz1BQPKqSal6yPWZtpaGiG6D15F4EjVseTy9VOkLopr6dLivXRBrXEjbgCjW9jzpy99rBlI+bx62H/kpnduFP6TYIKmUIc=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0169:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;20:XgPVUNYqR+padd/4D6WZawkxSET4gMzsUcnApI2J0bR9QJs+tpUJ68fG5+zyiTr5iZ3u/HlPatBbEUtVHDHoIEN0POQQMnqu7EHCdvmpyAJqJYhMw1oUfDD/5si2IZQV6ix/s7a6PT+qA2w9IFucm1H7BRzEmJvlgRsiGWUGLrNIJNgsjkl6vE2iF0PmTztgeABBdWJ9xNm7ojMdyTGN2Qdwa6CdlHN9dgyW5EGIn5A+bpfjZbBblJwwYi+Q4LEE4aptuclvCb3MjGAjkOvTm85ul8V+Gz6FBM0OlIk/5FH/vGtDek283zqw3Tx04KsvsFwNQzSY4OkFJjkyFWeRlalFl9V8qjsnKYKBsugruj26zFfKo6ELcMw8hjHyYOMYMddirvIveQa4jiNJ2V3rI8qnMzvVcIs7m2/FjHgZUgrXSa4SjmlRAaGnwkP5Wf5MMClILIENIzb5WCpDg9Fby6pcVkQqu0BoMlpUkQPdVexVGbtyFvxjx2fHFMjpmctI;4:7SQMIk1rsBNDxgf7LNXxGhZZjwylwOc5ews9BPQNJiVpYx7f/xStbBX1O58NJI5HGOs5tqJr40dhj2a0jW7g+TMOxVext+WgXqLYG5Qi95CS/iW9rQ6rpTZH8o/fuw/t8MDYUIenuKWgoTVlk2l23xpvA1M5/j+f8tuu7cpSy0+4Mhd0czLVk33g3+uztaVVYVH8zAmF18tEe5/xF4/+XICgGv5c+/GEOgu1uAkQ9bsAxOmFIdYbCXksRuiX2W5479swo5TNNqs7w80lqWshF069VAWpltWD3NzAVkMkNgp+3P8k2zmciCRaO2fP0ehg
X-Microsoft-Antispam-PRVS: <CY1PR15MB016911A32F16EB08B5F6226DBE4E0@CY1PR15MB0169.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0169;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0169;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(11346002)(8936002)(23726003)(486006)(54906003)(478600001)(97736004)(106356001)(345774005)(46003)(446003)(1076002)(476003)(2906002)(4326008)(6306002)(81156014)(7416002)(9686003)(81166006)(6246003)(966005)(50466002)(8676002)(33656002)(55016002)(7736002)(47776003)(6916009)(575784001)(52396003)(14444005)(5024004)(16526019)(58126008)(5660300001)(53936002)(16586007)(316002)(53546011)(186003)(305945005)(25786009)(6666003)(386003)(6506007)(6116002)(68736007)(105586002)(76176011)(229853002)(7696005)(52116002)(86362001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0169;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0169;23:fzJ2lBxUmdoUs1pC7NN75enf/ltinR7sUB+UGVyZx?=
 =?us-ascii?Q?78Xr4dHMN5yCscNSwSH6yekvBIyVhdsBmQRqyr+AivB+Ospx740jJ9sJq6y1?=
 =?us-ascii?Q?DYLT3FJW32q2hxlmtWjnzAMwz8F3z4BXnyh5UkAkioKv07GT/EQ8mZezMznI?=
 =?us-ascii?Q?FuUy1oSh8EdhmZeefff774ik2+GTi2DcRALALnI/OPiWClMBY4kpd6e9C2DN?=
 =?us-ascii?Q?1eZkRB6bs/r26jcy5pKnM69sPgNsAmjYpvLy2Ej6lsUgnVbOo7iqXZKJYaGC?=
 =?us-ascii?Q?UUwsEe9Qybc1wl3jqV7DS549hqv2fC3ciNxft/lhqi03ak71yJDufisU5dV7?=
 =?us-ascii?Q?Hyaf205K/5DKlsuJSKBc2zVnc1yRTDo6O2m/cKIfCXT8nA2vFkHBy7N8OcHB?=
 =?us-ascii?Q?wV3ai52M12BtaDDxOuf8ApurPAFUiJxyogYBQ1ruofHcYSf2PKoOc5TA8S6g?=
 =?us-ascii?Q?W3J6Yb2mFNfKCtAwYk9LAZFgeTv019dvL9tMp1SpxAP0EH/uTqrkCFv2QqV7?=
 =?us-ascii?Q?scS2eT9mNu11a71OD16Ccr5QYC3GTPAK7ghzl+sahGf1Xi+vPm2sLwLG1RAf?=
 =?us-ascii?Q?QTtAzdaHd8ry9+leTGuhkgjDycX4li4yBMOfXhRackDhwlcp2BJVhiKGdBuL?=
 =?us-ascii?Q?XzULjmP1a0swydvBG3/7a/tXM0MJALhvdk9j8MgT5Xc557VgoFofddfPG/sx?=
 =?us-ascii?Q?XY0cf0Whm6bHPx+ujNdSwZNutGzE0Q5JEVWryW7xCLpfBAFgSMpm85cCXNsb?=
 =?us-ascii?Q?QBLYlw/eBQ8038Ra/GkBEgID3CFvQPcTcWg+N2nw+Wqvx6G2BNKQSPT90swH?=
 =?us-ascii?Q?mFymAvupGFOM8P1KFrugvQX4A2ITb2l/JxUVDvnkjH+6cObSC8Ha7DsJTS4t?=
 =?us-ascii?Q?yIb7fJr8Blf4wEUHICrnVE5NK0tPbCLtEwzz4uJija+I9s6jZq9T+bV7Q4Mw?=
 =?us-ascii?Q?nfwFcEtEXJKp8s/YeHPZ9Z8ahmSrK3hcrddF4iuMr5iYiWZ25cTBjvlsszEf?=
 =?us-ascii?Q?Jg9OhHZM3kQdhdykZ85lWZ857SlawGA6A6z9ifq9Cw9gJSRTL1e3O3SoaDsb?=
 =?us-ascii?Q?FGWried+5kY3AdIC3BKpezkL3t0NsasjdKR617zXzDkEiB137WxBRznavRUo?=
 =?us-ascii?Q?BBrTLu0Tc0MGlaBtew/8bU6AKRCV2fakryiNSw313YL0ihVn88cGOiCT6ijH?=
 =?us-ascii?Q?gh5LM+NLOVFf2vk1ZWRmulw6nO31ZddBVu3VHZasMASn0vp+Kt9nwqU6L1tz?=
 =?us-ascii?Q?5cjL/wlX/nhI1KZPeDb0A7goTR3Vf+snbxhfolxn1JZtlCbck2n7Ib9w8GGi?=
 =?us-ascii?Q?L5bnDCp0wyFZDWe//fCQmpjerhAfVsJO53S45AJyx8RGy0lL+8Cf9gZYjV4l?=
 =?us-ascii?Q?cSv45sjyTAdHOy24MBVIwjM0Mv0VG35JJPLc3lFQk67e48U?=
X-Microsoft-Antispam-Message-Info: 3hjBOcPtxqC8paYNQEXcCVnXIK7VykcHJCyalkyiG/lidYU+aoi65M9pYNqGnrShgmf08JHKXOgT+Cmcsa2s11SnW3q5Fx2Kb1JfUzCWTn7wRIDA1eSLfBPH80umNC23cPTfoBR3MpI20VMRrzvuy9GpxwdbjGBv/4BH0c3ZSNY+dgqhv/1GE1nIP/kzwB+r8NZOgSte3YpXCMNANGEoevMlPX+muFOcZn0ucN6nOzoq1t6hioenHcv7p/zusdDrf7w2mKvCWBHnDTW3e0wED7iAQvGjDwxTGK7kK3qKodf+Y5Wm7WEFV6ACV7VGGthK89mKZPNlAUCWroHAHNgg59VHxJk90yUqst3aNcN9EzM=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;6:SVcn+t/XumSkxJmtPjS0ZpwgI8G2zwN7vTbkk4a1xBBCqJfbvFz0S8lM1wowOEr+f7ZYf7emFnFSqXCxYLxLlyYuYPA5hb6aPpoIb0E9BAuzOMQ+DRxnk1oXW4DmQHPAXRgF67cgS/WTEEuoa0Xi/YCAtF2fysYNmwUgDYD8eDLx1jchiJMRoC85E5bjHHhKB6JxurfvFu7qqXcZhhioJWEQWCdCaIiEariNf6GkgXNV4taJDlTtsg3EBsFnqaIpQvllRkmnlqRVvKcS+2nIjyJPljhQd2LmONVI1U6zloXaFDLEgDwEdHVn1oly0BENvS8vV4CK6QzJnMJYxwzx0ri5WpkP9xmtdHJkrE5wPgu7EbIF85/jVIGwFZcsCRKkLNfsTI5A3lRHIk6zpe1W02A9SEv8h19mooJF4H1/Irb4xX40+3MZUoLk6cHf+azPIOkMsRjFvBpGAwIFT2oDYg==;5:6MlurDMArwYFDRPUz2X9ctVIYomrBh14oVs6nrL/rDCIuXP1nYadheKFgo/Pfup7Nlzyzpawpc0/JwdlVSWiZMBEonIazZe7ttr9U6Y1tUvbGdUn3I1nNG9DGy7A88w/JiiZEZazKty0/wDBmN9jA5W5O+dUlWS/O4FLFJhs+38=;24:5PkTzzdlEybp1GC05H2dVTD798x0/W5xRW4rUiHcfOwyWeep7x85ZojLD89RfesgEnnSWVZqGcVqD8FuZuj9pxf4ATp12WdarqLp5M2lKj8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;7:21hCmDYIHyNFlQa5MmSmXWRO5owMfiq8YX/nTUcyigHRg2nc1WwfPc2hJU7khisY187Jg4A1Vq82Ar2WRxOKdluNWZ0ty5NB59Iz9m/Y5MGnmOqyauBfFd5huADaZuzewPQxeiyHDsZxZBFEBfDG5RnBoxtTIQxxkeOopm6XuzTX5ltGKi+N2ONO5h452Nz9AGe6GX0DlUSG+PKlYAQXAOJFHyaCQw/kI8le23/LO1CGBcE1TDkW+mYETXYZ/5RP;20:3PfTjHHl/dQHiRZ4UcWru19m2REgWxIe3IsNH/M4+Q0I3kuOT8zLIN7D8mS1M8dfygf9F9aS1bb/1NEIjopbtqxL2BjloxOTrgi1gxjrKTpXCspzXRZ/B6ECI5Pe+qHY6PP0CVs0y+kkDwzftaF5qidOENWm6sP8VS8/al7ipV0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 21:12:11.4068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e0f3ed-06fb-4122-8a23-08d5de04fbe3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0169
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-29_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 05:37:02PM +0200, Vlastimil Babka wrote:
> On 06/20/2018 01:23 PM, kbuild test robot wrote:
> > Hi Vlastimil,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on mmotm/master]
> > [also build test ERROR on v4.18-rc1 next-20180619]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Vlastimil-Babka/kmalloc-reclaimable-caches/20180618-172912
> > base:   git://git.cmpxchg.org/linux-mmotm.git master
> > config: x86_64-allmodconfig (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64 
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/staging//android/ion/ion_page_pool.c: In function 'ion_page_pool_remove':
> >>> drivers/staging//android/ion/ion_page_pool.c:56:40: error: 'NR_INDIRECTLY_RECLAIMABLE_BYTES' undeclared (first use in this function)
> >      mod_node_page_state(page_pgdat(page), NR_INDIRECTLY_RECLAIMABLE_BYTES,
> >                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    drivers/staging//android/ion/ion_page_pool.c:56:40: note: each undeclared identifier is reported only once for each function it appears in
> > 
> > vim +/NR_INDIRECTLY_RECLAIMABLE_BYTES +56 drivers/staging//android/ion/ion_page_pool.c
> 
> Looks like I missed a hunk, updated patch below.
> 
> ----8<----
> From a0053c64c72d7e094252d0d7462de8569d87c543 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 22 May 2018 16:10:10 +0200
> Subject: [PATCH v3 5/7] mm: rename and change semantics of
>  nr_indirectly_reclaimable_bytes
> 
> The vmstat counter NR_INDIRECTLY_RECLAIMABLE_BYTES was introduced by commit
> eb59254608bc ("mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES") with the goal of
> accounting objects that can be reclaimed, but cannot be allocated via a
> SLAB_RECLAIM_ACCOUNT cache. This is now possible via kmalloc() with
> __GFP_RECLAIMABLE flag, and the dcache external names user is converted.
> 
> The counter is however still useful for accounting direct page allocations
> (i.e. not slab) with a shrinker, such as the ION page pool. So keep it, and:

Btw, it looks like I've another example of usefulness of this counter:
dynamic per-cpu data.
