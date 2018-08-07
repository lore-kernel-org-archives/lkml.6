Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8691EC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E0821A52
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bpxWDj01";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bujOGvoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E0821A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbeHGCm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:42:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44886 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732347AbeHGCm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:42:29 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w770SefU027912;
        Mon, 6 Aug 2018 17:30:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=kWvvPmsDl4B5s99IW+lAYl73CreZKDbnT3SUU1A8QqE=;
 b=bpxWDj01fV1C8V39AGZ8GZ5snp2mcAFhuBCWIkImx6K17hHLcpp+9OAUiGffpTvOG0Za
 cYj84U5pfZctIryTHueVTfUKuwmbgYFJ+CW5+hvvUujfzliUpZnRyUbDG0ihSfPt8RH1
 7Bfw1AVUcxzcoZBAFQPXqPRYSD4tQMmN12w= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kpx7xgd3u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 06 Aug 2018 17:30:36 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 6 Aug 2018 20:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWvvPmsDl4B5s99IW+lAYl73CreZKDbnT3SUU1A8QqE=;
 b=bujOGvoNMwV91+NbBxEAQ/8jiw5+8bdowxfRsNBGVufVSF5U5bcP+4FrQYuN031nZz23NzmBDOS0Y0FhMMBTmYrCOUrxTyvEfnCVGRPRh8ISiPtOBIq7ym0AcPjX29RfOXpOILrCLM/oiwNm1569UEzxiYW5B3ZV7mfE3ZRpsPE=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::5:1ccb) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.18; Tue, 7 Aug
 2018 00:30:29 +0000
Date:   Mon, 6 Aug 2018 17:30:24 -0700
From:   Roman Gushchin <guro@fb.com>
To:     David Rientjes <rientjes@google.com>
CC:     <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] introduce memory.oom.group
Message-ID: <20180807003020.GA21483@castle.DHCP.thefacebook.com>
References: <20180730180100.25079-1-guro@fb.com>
 <alpine.DEB.2.21.1807301847000.198273@chino.kir.corp.google.com>
 <20180731235135.GA23436@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.21.1808011437350.38896@chino.kir.corp.google.com>
 <20180801224706.GA32269@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.21.1808061405100.43071@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808061405100.43071@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::5:1ccb]
X-ClientProxiedBy: MWHPR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:301:39::21) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6182736b-b74c-4b08-716a-08d5fbfcfb2c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:hXDjy8P0qkK4tVdDzBLWr7flBuj4JP8XixWXlZjUSZJETxwnWwLJ+URZffbndD3M/0PLENjBnvY7uf+FFaVhh8q0gOsBD4f7PX29Md3AIlnRas5D7XLldeX/Fi6mGPTgnBByZ6IFMpz1f+6hCCWBQ2qU+Z+HeQhBDILZ1qWMxSDnIphxPEqkKRDYzrPDjedO4NgnKrRtTjFhXsjDeGpUhwWSFOwYklBySHbWgz/4tLaDj1pMfTesyckxRNmDZLbO;25:rvA+15u5MiUUhtZq0EDmhrMUfcLOFFYtguhtCIM8UaMNtYpkcccVV2zbuTav/h4OuPJQblOaUWKrQqpD3ZX/jImW9Og3po8sG3QUdOa82cdjkDiJ5tM2cmD+LyLvKnzFKOCXuvDHS9mctwKIHEYNmkRlXHwX8FW6Xe4a/dpOA2YLLPT+CmYI6cXtljzX9gmNYLsH/z6Ry69Ub/gvhnuy6D0OcWzEj3PxMGssc2Oek/dgCtmZejWBSAP49DPkwpzLeprvTJ6jCH8pYwwGuSgtJg4+ABSGLhcvONWwkAWpXWpnqluUHZHWnMdxd4hx0k2cx2xBnp5y+XL8snaoBBtwyw==;31:fqbaEg+yAAsDW3Hk1UOxEh4TYlou1zI5R99s4+83MoF4W9mJeYl1AnHa6pcVVwJiJjGx+jnyzcbsnNjVIJviTVKYCpC4I7Uywev3cWAtEkL0rHTKpJQXr9PyQNxbf6tLN+T6yhP3gB9QGGVPPNeSO/C4C5mWiF9uN1jHMKTPxHxZurrpl6Wvqhsf7C3CbB95Wr5vFaTtTOS3oyBBjIO+F6QDhWhM4thT4Bz4OWySLcY=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:+97gkmtR50af2yQZlWRhbsreUbXQ7EahhWwbL3Z3i6M64SK9YrtorOLj5Vgngkr5IeHxSUnyurG6OMlqZ2NOkSLzUzsby5fG6NLzhXtRBPgeMvwcR1+HVBVUrYFIXSfPEdcBLQDxcULuEXXWwS6T7VOCw823HkN7kBMwIcj5IUoYpWS+DtMqwF5HnbiOHGB251PD0zuNMw9L78fw0FNSWFzsNDl29GJOFJE27IrnF0dGAnBIY0k9ubwcIrhoOq0QiLzhW8YDAW9BoJCgSi1Fybx0zXNXSVHcr0BSsyXSJQLAV7G+itZlF+g/tFjzHVF/P7v7mmscLmDjJgJ6nB5KFeuNkNO1t28YxRKRs1fJM8sDfc/1TE/HpahuKf6JalymIc5kY9uypqOyxBf+gv3Gs4yXQM7gsNwfsdR2z4xvuqIr1/rg0A4Y/r3z7FbVZLmTKYVzIdfP/D7viqYBqC6jwrp++pEi38t8gQL6fxvH+TlXf+IUz7SdyteMznRrXDhH;4:NSfonRdVi3ji09ZpW7zrAHX+pJtjMzLljVKKznvvw6htrZuMeG/PgNJftHtcV0AMWNsV60s4120BnjHTPvsiRXhC0VTdFk8csFM4JdQASo4NEX1HU+qwAyDNB2oEe6LCOo3R8J1KLli8Y/o7Zfrc6Dvxkjt85TOT8k/OlI2YuMIYt46bFEKPYJ6rhhMfDUbSYuu7xxggKZo7LnUXXE4H8yHah9jF0Aa2jIBAWunCWMXIsSKqSV9WDjO8hNNlB81DgwMIvLbi+x/hNV22zKX5oT/YNLOJHMHMXparbqfryNxR3XVA1WPTCcDIBJUy56rroMx/dWkwcdDcXQRDZOxSpVC1T++78knl4UevaLQSKYI=
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167A025331DA6F821EC6000BE270@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39860400002)(51444003)(199004)(189003)(6916009)(5660300001)(476003)(68736007)(33656002)(50466002)(486006)(55016002)(7696005)(52116002)(54906003)(58126008)(93886005)(76176011)(316002)(53936002)(14444005)(229853002)(9686003)(16586007)(1076002)(6666003)(6116002)(23726003)(305945005)(105586002)(2906002)(47776003)(8676002)(7736002)(6246003)(16526019)(186003)(25786009)(11346002)(446003)(106356001)(8936002)(81166006)(46003)(81156014)(478600001)(6506007)(386003)(52396003)(86362001)(97736004)(4326008)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:CSy8a7Bt3IMJiae1MZ+24q1nQp7hocmcNJYuGVM2V?=
 =?us-ascii?Q?tU/GCspLyYjl5tPBoQcs/FK2kZzcf9zS82k5zufFvA2zU8BTOZ6FQdCxteEY?=
 =?us-ascii?Q?9bp0WTUYCLOb42u9tl4e7lLGxdlP7PBlCZ3Ht5tj4NKG+dA5of8f1P0x8ZkX?=
 =?us-ascii?Q?eB45yVHfTiCe0ioQ+tdChJcWDCb8/cXuEITCj6zrpH5POkYDA7/rgct8VL6S?=
 =?us-ascii?Q?WyQ3pgNkxZv+3dfQlupFEbgwE0/koFRkEyj0r3B3nLXdPPJz51+AmLWsrvcx?=
 =?us-ascii?Q?r4DR/A9KmS8rbc3FSJmQmvco1QP0E1laP3TKJEfw+rDNnyvtB7xUmUJrHV2C?=
 =?us-ascii?Q?JgxOHUjdlFKiNQeFNJl74ACyBcD/2mPkzOo/3Fzq9bKh8dPYqDw6J5dNtH6L?=
 =?us-ascii?Q?uFS8snMLuEioSu4NNVqCIf0uioDpYWjzPKhQ0lPWbkaqmUlwY1q8Q249bsdz?=
 =?us-ascii?Q?+fWUmbe7gicHknf0S1WU88Fc9Rt3qN+1ajlmwtt6O23sZ/pmi1fp8vwlTOi2?=
 =?us-ascii?Q?KA0gkZQckO4dBpb1yKvCV8lqIBooVEB2y97PohC045dEDtlsCRUr6TRjld+m?=
 =?us-ascii?Q?/339mWg+2CgOZMxIQ+7YGGkSXUqLHL+wvrHMQvyft9/m8GhSyImRSRUApGea?=
 =?us-ascii?Q?YyEwUpoBtBQaO5Lha40lS5jYeuqYzh4KV2sCcL5Y6LMgWOTzUEgw9Yn57YAR?=
 =?us-ascii?Q?f5Ly14ZY+CezRUtLI3xUTpexxO/ACps7o/DPQ69BpFqDTgpIuRIYjtBczvp1?=
 =?us-ascii?Q?pEbjrm6JaPZIkk0dhJdsUEjZVobVBZIK6VAEFqyr8kZVMlroR6BA/I8YIepf?=
 =?us-ascii?Q?9/Z5ivIfgPvltftf1Nue/lRHiwmy5DqFPVtrDzjNDyg38BtyJzbI8igGUki4?=
 =?us-ascii?Q?OZaMj5IWZvi7Uu7PMochL+rzpm3uAldkAdO1uJ++D+0gateCLXaePEINjS5y?=
 =?us-ascii?Q?DkHtI1WRdOCMKOomsQ77TDBqDVokX0Yl52GytqYN/4/FlNC9ILmSCx5L76gi?=
 =?us-ascii?Q?3ZSdL3peXC5C3wn3SkWnQGu+YG7ujcL7ao4Dc7YLtAb/K6kS/jf1aO8BjaEi?=
 =?us-ascii?Q?wDZyaW2WpuPy1Hf66JIbjwaXgqoD1IC4Pt/r3ri8qBwudWLQVqCfpZJ1G5SU?=
 =?us-ascii?Q?HNK3wtJkpVe2S69fc6oTw4QWkTUFjS2G6A7Y83Ku7QEkpMUr2/+UK29/y53t?=
 =?us-ascii?Q?1YP7Yxzf1g8opBxfY9HnTfqGJwwHHzivtbiVX/5uAFFQJxTnJq3kTpmwTAfD?=
 =?us-ascii?Q?EGOeLcahjAAFlPj2DWBRz9506b4yliakEQadDEOYbypxFuU5On0eE6M6FVgJ?=
 =?us-ascii?Q?fyvSRYPM0ORS2NE5NUPobo=3D?=
X-Microsoft-Antispam-Message-Info: xByh/b3BCa2taBK3CrSepNjdZF5Wf0k99rMv5yXWXPLKDt+ZCZfGfnmoHolgfvn4SfSTbwIgtJ8rqX0rTUt3TQ3uOxoWo7YcbV9iZaUgHESQgw2e1ip8gaHVu8qAX6oTrTzrZiVK8MOp+TFsLeaWWyvXvOV6HYQ8p2PBNQSB/sJd7jgZAYx8L5Aq1nMB5he5SeVp2HqOXThViN4emuTJh208L4XtonV/NfR8+vI35/Vznh0C/IlBySqE46+N8KFPFaIfsbLMY1LjPPTAqR1CsBiHP++86rmEP1dk8/rsJWpUUM+jZyn6KjSeoscAqoVPvh36cZnBo5GgXohW/8qrddLTQ4L+Q9uoqouJMH0Zc9I=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:Y59pD2XGr2pfxKWfEpk86FFvUJ3JYrpcuXev7JIxEkU/SoZ6XRu1+OxAEcEchwbhx8GnCHV26FYaZhD7bpc8Ai7yaNioj0ZAr4B1bzZdd2hEBDVb79FmFmvIHbxHnpwO/aNGJ1JRW4nbUdIBGACJ8YbUlK8EEOXnTDNER5tVn7S9FsJel/b4ax0E03Ds3vLh4EVvPB/RwY4kWsFOoa19RpVRhCGaJjWiDRzr/agd6Zlp2HGhrjym4x/68Z/AYMHOV4DVbf6LMpgD6DuzFj8n1J2w8MkdJGiI5sYS+cYHo6iVF1yicIRpD4r7uU4vL0gEISgHkK5rwUXMi89QX/7PpwWySKRcf3MI0p/BUtMJOIA3p4/aqw0N1/zJ8DD65jNOb28MrfUFGptQw6NLBUCnWkBK5zFInp5pniQYoLgFGIRruOIjnpL0ZItwBCQRsdw4VDtMcZFUzA/TAcbZpryM0w==;5:cm4ZxcOWjtjrJNF76pmR4XDvmbDuY3xCoB2MnrT2RR9cpDFrRIVt6Aee4vlON4dB2Ij74UkEp3JLWzc1o6wFfxr0XG2ucpwFUyWAqLGnVh7IBWO/XArwW3rbPX06GODN1CVzHaE1zuZp1EHxzqaZfVdrZdUF6dx9RGMNx+ep3mw=;7:fJ7AUxJW3Pug9QgMwZnnMRbQkBH/UUOXcK5MaUF14ytJKTFcLKqpoiJpOdWStMnNxrMkzfIdwvL0xUX9fQAZV+xlMv45e1gK70rwPAUOZmY4j+UrvnBY+eyofmJk9al00ZMaTyz1RgWwvG7Fy4hV6j8u2lUHiv/cMgzR8zT8YX/LMjNUPPujyjeuSTTNHjHEbawCtYN+nofghn5+1uk6u4LNAAXxkTsOGsmiiklYkcNWIAeTWn3IDfFwVguXJk7s
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:8dFEeXvi1mJQzDQLvBEVMzKzhcPPZOyvV05dTNfJMevg43r/UkMMSlT67rxdYUdyzOooohgEWeN9q6QVxFbcaNwIt+aTn6N7FahZYEDoQxVL6s+IClXRpYCUXNms6echrQLS7Js1mA+vKgbLkSoNluG4EYZhic35nvM53KlGFqQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 00:30:29.8377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6182736b-b74c-4b08-716a-08d5fbfcfb2c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 02:34:06PM -0700, David Rientjes wrote:
> On Wed, 1 Aug 2018, Roman Gushchin wrote:
> 
> > Ok, I think that what we'll do here:
> > 1) drop the current cgroup-aware OOM killer implementation from the mm tree
> > 2) land memory.oom.group to the mm tree (your ack will be appreciated)
> > 3) discuss and, hopefully, agree on memory.oom.policy interface
> > 4) land memory.oom.policy
> > 
> 
> Yes, I'm fine proceeding this way, there's a clear separation between the 
> policy and mechanism and they can be introduced independent of each other.  
> As I said in my patchset, we can also introduce policies independent of 
> each other and I have no objection to your design that addresses your 
> specific usecase, with your own policy decisions, with the added caveat 
> that we do so in a way that respects other usecases.
> 
> Specifically, I would ask that the following be respected:
> 
>  - Subtrees delegated to users can still operate as they do today with
>    per-process selection (largest, or influenced by oom_score_adj) so
>    their victim selection is not changed out from under them.  This
>    requires the entire hierarchy is not locked into a specific policy,
>    and also that a subtree is not locked in a specific policy.  In other
>    words, if an oom condition occurs in a user-controlled subtree they
>    have the ability to get the same selection criteria as they do today.
> 
>  - Policies are implemented in a way that has an extensible API so that
>    we do not unnecessarily limit or prohibit ourselves from making changes
>    in the future or from extending the functionality by introducing other
>    policy choices that are needed in the future.
> 
> I hope that I'm not being unrealistic in assuming that you're fine with 
> these since it can still preserve your goals.
> 
> > Basically, with oom.group separated everything we need is another
> > boolean knob, which means that the memcg should be evaluated together.
> 
> In a cgroup-aware oom killer world, yes, we need the ability to specify 
> that the usage of the entire subtree should be compared as a single 
> entity with other cgroups.  That is necessary for user subtrees but may 
> not be necessary for top-level cgroups depending on how you structure your 
> unified cgroup hierarchy.  So it needs to be configurable, as you suggest, 
> and you are correct it can be different than oom.group.
> 
> That's not the only thing we need though, as I'm sure you were expecting 
> me to say :)
> 
> We need the ability to preserve existing behavior, i.e. process based and 
> not cgroup aware, for subtrees so that our users who have clear 
> expectations and tune their oom_score_adj accordingly based on how the oom 
> killer has always chosen processes for oom kill do not suddenly regress.

Isn't the combination of oom.group=0 and oom.evaluate_together=1 describing
this case? This basically means that if memcg is selected as target,
the process inside will be selected using traditional per-process approach.

> So we need to define the policy for a subtree that is oom, and I suggest 
> we do that as a characteristic of the cgroup that is oom ("process" vs 
> "cgroup", and process would be the default to preserve what currently 
> happens in a user subtree).

I'm not entirely convinced here.
I do agree, that some sub-tree may have a well tuned oom_score_adj,
and it's preferable to keep the current behavior.

At the same time I don't like the idea to look at the policy of the OOMing
cgroup. Why exceeding of one limit should be handled different to exceeding
of another? This seems to be a property of workload, not a limit.

> 
> Now, as users who rely on process selection are well aware, we have 
> oom_score_adj to influence the decision of which process to oom kill.  If 
> our oom subtree is cgroup aware, we should have the ability to likewise 
> influence that decision.  For example, we have high priority applications 
> that run at the top-level that use a lot of memory and strictly oom 
> killing them in all scenarios because they use a lot of memory isn't 
> appropriate.  We need to be able to adjust the comparison of a cgroup (or 
> subtree) when compared to other cgroups.
> 
> I've also suggested, but did not implement in my patchset because I was 
> trying to define the API and find common ground first, that we have a need 
> for priority based selection.  In other words, define the priority of a 
> subtree regardless of cgroup usage.
> 
> So with these four things, we have
> 
>  - an "oom.policy" tunable to define "cgroup" or "process" for that 
>    subtree (and plans for "priority" in the future),
> 
>  - your "oom.evaluate_as_group" tunable to account the usage of the
>    subtree as the cgroup's own usage for comparison with others,
> 
>  - an "oom.adj" to adjust the usage of the cgroup (local or subtree)
>    to protect important applications and bias against unimportant
>    applications.
> 
> This adds several tunables, which I didn't like, so I tried to overload 
> oom.policy and oom.evaluate_as_group.  When I referred to separating out 
> the subtree usage accounting into a separate tunable, that is what I have 
> referenced above.

IMO, merging multiple tunables into one doesn't make it saner.
The real question how to make a reasonable interface with fever tunables.

The reason behind introducing all these knobs is to provide
a generic solution to define OOM handling rules, but then the
question raises if the kernel is the best place for it.

I really doubt that an interface with so many knobs has any chances
to be merged.

IMO, there should be a compromise between the simplicity (basically,
the number of tunables and possible values) and functionality
of the interface. You nacked my previous version, and unfortunately
I don't have anything better so far.

Thanks!
