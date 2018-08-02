Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBF1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E591208A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HCFJFQMi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VN4gn48X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E591208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbeHBCj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:39:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53968 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728135AbeHBCjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:39:25 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w720m4uX016019;
        Wed, 1 Aug 2018 17:50:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=PHHHls47tKtTlrH1ZO/ghv/MPn6DIQZTD8p8oCMRAwM=;
 b=HCFJFQMiNf1cX9rx/PCyKyG2qH5xj9uVltZNY82EOBmd3lQpiDNAKUtLzHbfhH8sFseg
 cD0KYqf/utGgxW74fxtvqdAGZS7ma85PKTGH+uvp3kAmCTvbpood3r0JVmYqvwGjA9e9
 YB9wWkwLqlonZyRgDZ7ZQbehdXL8JDeI9cQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kknssr8sq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 17:50:37 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.27) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 20:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHHHls47tKtTlrH1ZO/ghv/MPn6DIQZTD8p8oCMRAwM=;
 b=VN4gn48XrstjwbHXJUKjAmtvkvVNJ5cWH+RX7feP7Sf2W2EgfP0zIozkmgnP6NC7MGb/2zQ43n2vn4OpDIFWqTTq99R8eICwDsxNEiDfLXsgb+Q+BR7M6OntYjsHkiwvNi8Jvv0CDn0rYDE79uu1KP+jvFVEdn/7fEnDFFB5ctY=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::5:2fa7) by
 CY1PR15MB0170.namprd15.prod.outlook.com (2a01:111:e400:58bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Thu, 2 Aug
 2018 00:50:32 +0000
Date:   Wed, 1 Aug 2018 17:50:26 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] mm: introduce mem_cgroup_put() helper
Message-ID: <20180802005023.GA1881@castle.DHCP.thefacebook.com>
References: <20180802003201.817-1-guro@fb.com>
 <20180802003201.817-2-guro@fb.com>
 <20180802103648.3d9f8e6d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180802103648.3d9f8e6d@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::5:2fa7]
X-ClientProxiedBy: MWHPR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:301:3b::34) To CY1PR15MB0170.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6377cab-bb7f-4f80-322a-08d5f811f42a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0170;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;3:hwcgSlFb5nYg+YsCJpdlkkgTtLNc1+GCw/dw97kp+J78Q/qxqQmtVpVBiqiulHPlOKEDPjSS+pZlqFUgPkW3hjlBJ1/7ast7xl3SwwxhuHQKmKZ6mJwKLN3j0BsKhaegCGW+s1ZJfHyM7Vs5aW1A02KlcbHOql5pvYc/myiniMwLpls+CXzL7IUKpRot/XXKiT2MR+VkVdAwDzQ4A3DFSS4pVFVGSodeulP915J64prUp7IAJRoVdhnwACDyXcIW;25:M6UMmXl1bT2r5TjBknPikohFIUURWHJt+ypffVpJH9kwRgkRpwasutKYwqSsWPbaWKjzO9JHZNR8M+H3O+GbmYTVSUyFWDZzRWfp2Ak22fSdPW3ClXV+q+FJDUhZa41D92pyN1e+3qGTGjRO6QSU+rS2ZQEwi7FI+hD+jZivCqAqOM98fQM8gojwK7rI5gLgOgOnJCvkW9NYM6uBt8l8WIcjI9fmfp4WW4ApabvQQHCyejgXfH7X0Ho4ckDbA6gp1egKRemGr8kicQJTgpAipK8CLaPfe2JAdKfQ2BQ2DEApDx78kIxg12iEvBz+S4DZSkdANtuiQMMPF2bqfhHdxw==;31:tSrAsaPDWcy852K2tRzWpS1ng00xTJ2/7nhEK+jSw99mZGKBFl2y90bAKwYW/BwBGzkZHC8wFPkBODX08nXuOSDO19vWcYY4eLyx3JTdPKpeE2tkJ+RtaGUSaNGmqfWfDo59rRMHfScIOLVW0Z5Uho0XL/7+nOCq3Li9J/epSGdETw7C7Hlt+Gc3BOtqyqdwICW4FGlT1NR59h/Wl80WIhK1K4MOIJMzJYXgOTA4AQs=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0170:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:CVpU4Ee9OoixdHmFWnCfUp1imWx/tqdCzr+YeOUTpEk7awPWDHy0G5JyHs7aGJ7eQhuo4IXrhpiPStLyRUcTdfZP+lLB+VA7TTTLvlQJ3jgCKAdyzNoAKM0hzUmA2R3IVF/sRtU3c+GDFFRduQH3YjS0lRMpjVtRwTJHv0tgKHPe5LtSyfuQxfT+V0fewzfcvS+5dOJV6RRTImERuUQCpua8veVGll7BkIyS9clTrhDHImHtOQc5MgZJS4hXCtSt4FedUSrj6MRAIyJppE26CeW09gy0ovocrrPNVCQSHbXOxKhdf3IQsRLnatqIdIrNS8TUIKVgBnsZodUjA3jnJO/TjrqWWI/xr6D5nea88TRB1OALsjO/10/kUNpi/IsMu7ytgus18cVXi62BD+Ct6/mdx8hWA2wec+329IDohIh6r0JlRFazfD9oYhKZPqrcVmgI7oPNq75YI+T0L35l82+qcnvataayBA/glcknPiRlwbVA2kPiYLWcPYtAXiL/;4:12nrXzrL+EIBvBnG/CjSBgn8zjqDuZmszBk9ELm8qel/eqTY5/ho0ZfbHVGzUnvpCBGfpHdEpLAgLLOYyY1lZp8ZA65uuvfr/YFXa87WxjmOIuCjGmZQGeCRdrIqJMVdKeUNRZyLCC6M1VWfzhmlvd9a0/K4BeP2U13w+Nsmd93G/zCG3vk0euTPVKed2MZuu3758NrwIvvWS1iv+EfBQcf0mY92UGOi22TcapcchGNhoWQJOY4Ek2HKKjRYJYWvGP8mEPjmxlXCylP4K0QOkUYVifX1sE/jvnywRhrIyLvJrgpz/lyRqS+z3CloqmlBj9X0SwnjdHT0dKBTPJL8pGMut1Pj4UV5lX16H6oaVI1Bzy01KSasSVc+HAASVv48VT80/55fMyeDhCsWGo1W4taJe97PZ/Bn2vtnG0uRN7c=
X-Microsoft-Antispam-PRVS: <CY1PR15MB0170F2290525586594809B08BE2C0@CY1PR15MB0170.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(42068640409301)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0170;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0170;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(23726003)(9686003)(6306002)(55016002)(5024004)(54906003)(58126008)(305945005)(476003)(486006)(68736007)(7696005)(52116002)(478600001)(76176011)(47776003)(7736002)(52396003)(97736004)(86362001)(16586007)(6916009)(5660300001)(6666003)(2906002)(966005)(6116002)(1076002)(316002)(105586002)(53936002)(33656002)(6246003)(16526019)(186003)(46003)(81156014)(229853002)(4326008)(25786009)(106356001)(6506007)(50466002)(81166006)(8676002)(386003)(446003)(11346002)(8936002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0170;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0170;23:B8NMtvvwJkNdgHoAfDKiOkpt1IVh5nvM7DIRe9lra?=
 =?us-ascii?Q?YxsfG/SSg2soabiGcgBjuI2Bd6Z0xn5aT6K43WpDmT5LpmILno4FmqYMaKoM?=
 =?us-ascii?Q?GfIcbmOGQ55QgHYACAyUDqdXY6xHteAjrjYuFhQNRqo58/SFLAwi8KV/AjMa?=
 =?us-ascii?Q?oDIcLONqNcS+Cnq7xstvEk220xT8d9uo4LdyXKxkh7iFuYr7DuRX2aPZK+or?=
 =?us-ascii?Q?d+xDeiV2t+9OT9quxBlTvICf62eQHj6K1xOWjyl2t4/OgIMsrRUoxWaC7RxK?=
 =?us-ascii?Q?Tf5GKO56yr457Cx7V/OIXbDBMDs3i8bysdQuAkuO8agif3pQ0rqc61uCqv4c?=
 =?us-ascii?Q?w7jPebvXEYwgR82TnDgPZkPpzhI850NssCv9p5796SNPXvWnHKq8Cn5iYl7+?=
 =?us-ascii?Q?bw5mJE6A2nS9Ybbny+hvmpLB8Zz8VGn+vAUVuY/T/3ZljdtVA5l9wgT8MEw4?=
 =?us-ascii?Q?LTTEs3YtRn+Uv6XiIna98/qngYrw+ST67a5wQq7lIuKAq54jhqlJyc9+6nx2?=
 =?us-ascii?Q?eiL5+l5NaLyIUkG0EGJlWE97r9/uxeMhBgxuOM8gIOl7qEWlytos/Ht8d5Ji?=
 =?us-ascii?Q?KQuqfizFGl/dkog2Jc/7B8zrWLqHZB/RK+SdBHQJZ4hg/+SCYu9AYmHhZdjU?=
 =?us-ascii?Q?WrCpGOLSvjKFCpRr2WgeZ++uIxw3ybTKAX8CIxtrnPm1NHjWNDdruYwJKwwx?=
 =?us-ascii?Q?qOMdnLMtoMIzIIOs/w10zSTbwi8GbubYfUjDHzK4uE4nD62ZhBWzUOnlasNr?=
 =?us-ascii?Q?QsAPRmxz/jtcx31uLJ0XBEeTntoWuLKkMQoSgwsYrjcHwNmIGAkxPhWsOXxl?=
 =?us-ascii?Q?JwyXZDnAfImFKVjW7/SXHHvkgDko/A0ywf4nS4OWcIlSi6P0dfxL07CmtmVN?=
 =?us-ascii?Q?0aUCZ2r/EItv7gEyJa8mpJ11ZYGp8RHNnnu4F6BhZF0svmx40sN5mnJRyg58?=
 =?us-ascii?Q?FQjk+Se/pKida6jQAjRZtfqjuZNIrvQpESXGrdWu7O4Kk7y7pU8/Sh/WSWKK?=
 =?us-ascii?Q?pwYQCwn2Ztzs0MaiL6HLSe8g3FlcFqxZ6P0zt6vECYGGWasXXnF8klwA9Xkc?=
 =?us-ascii?Q?nKYKuj3Mpwl1GNrwBO40gInqSflgQPG3hYacW4tgv+BJdZcrVCJsrE+5axW1?=
 =?us-ascii?Q?1KJRSSbPkQG2WgMVSX1VNY/W6ISnKCtlACM6UL5tFXqzfctqzK+cXhIRa6p6?=
 =?us-ascii?Q?crEE6y9k4T7HA1wXeWLwwgnzvr8Dzn7qAkS3f4PwKSOr8jhvQl7V2ACWF65z?=
 =?us-ascii?Q?hJIiIPpxMpJJa3Rm4YbpJNzmuxiUqQ1oP/xyRtpuhOmzN3+m9QBCyhhGmWk7?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: J2/VkD7vHryEen7PHd/YXX06LhTD4Hhea5WLO2yK0uKkZLUrrEzbI06tDe7/a/FJjEBE6FEh/LQOtA2W/qQBVKh6OUKUHfsMTOFSeTJdJrBOqkjLoJcDaDsIlBkb21T1i83g3pBtV4h6dkRwkn4udGkMkVCjpkjGVyLJq2yrnQsRvDp7oRwdiPBpwXAk+4Vv1iZsFKa6SFLhWknWSi1F2wsFriC9FAtckCWtkfwvXwWCCBXvWHp2ekDi6iSs/3LVX7DuatC1yjzy5C7PnHfForQ0e5yar82gVzBKuTiE973RpVBmcS2Wokyh5UeU/zr8PdBTODhbiYCm6Oson2s31b72fjgDGXDssIpr00Z7tdA=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;6:WTBAsoyGwjzyMOJ8xFWV/KYT96/7oUk+yftdw0PIbnMvj7ZB0HXD1mF8Hgr2mbNkgujvWjQoH/z25dINl3kGCaQA1XYWyJEMhI6LTovdOlx/UZig1vBXkrwqXJyKRPL5iXnIj5pp+uU36sYagIS8AEMRcO34IS4Wfh62Ti1jrLYmY2lgOIKnO2i+N1+lj4LJouE234q2kheOD5v3fc3z2pnT0HxjTnaJAPF1VjGZWgFm8YYLkxAqLQyHpZeD40BiF3H1Ej7nlT0CeHslSned+65WSf9jZVqrmV6eBqbiFIGPOBDGSMrhtRw+l5bRy7Y5IqbuOdTNhQ1fKwLNNYaM2FVDGm0Yn/iTHBFGyEjKAdSn85Ab/tz+n4KgRNhwZ391hSR7QeZNmSj8sq8lMGXiAqBhB/2lYY4WVXWFK+qJxDBnW0JUkayO1wEjSZPRuduqEUG1w/xsbVuBj6ezTu6T1Q==;5:8zf68WTqIio2zY7GUzeU5nhb2Ol9BNbK8JGQJaIVBpXjawZz/wkxL1GQSaMeszwyE5BhsDfa4Ro5MRSyK3BBplFNx8Op3qmr4WAnCLbEdPIBxD6JD+5C3Xm7kPEtHeilrbr8rVtnvMr0Iu43+Lzfvwu07zThPGt1SYtJGi1oBUo=;7:ISzt/KhSx+7n0lH2VoMc9+cKptL901KkgJLv0NUkGQCsH1wPgjPrm1HhDJl0c7tzFS0euQ1DwswnKrbrF9kfMrjc9njCSFvMona6HVfcXUe73PDqGB0rbKAAkjy99m3IsELTKa4ClL8XzsygmC1QmVPTQ5z8D+xJcyOvGwSjVZfML5GGrQWO1myKTb0nw01/LQxqBb3b9WME6tzIsAHbNh678FtFb320Fh7KXZFxLHmmNadUiIVXSPQDvr1C95iU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:QJDclAw7iTB4KkNiKqZFnf/8GYO63ir7RfVKGKx5ahOz+Ehncu86u3mC8B+0d/V4RlIqyAkVyhGnXp+WHkOgFPQnez44/HdoIawI4xXamHWQgcVKHolwoM0Elh/8h6O8YxxOAqMQvnbGdwpwFV9xIh7y0msMQFm4K5RHFYB2W34=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 00:50:32.7443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6377cab-bb7f-4f80-322a-08d5f811f42a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0170
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 10:36:48AM +1000, Stephen Rothwell wrote:
> Hi Roman,
> 
> On Wed, 1 Aug 2018 17:31:59 -0700 Roman Gushchin <guro@fb.com> wrote:
> >
> > Introduce the mem_cgroup_put() helper, which helps to eliminate guarding
> > memcg css release with "#ifdef CONFIG_MEMCG" in multiple places.
> > 
> > Link: http://lkml.kernel.org/r/20180623000600.5818-2-guro@fb.com
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Acked-by: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> I have no idea why my Signed-off-by is attached to this patch (or
> Andrew's for that matter) ...

Hi Stephen!

I've cherry-picked this patch from the next tree,
so it got your signed-off-by.

Sorry for that!

Thanks!

Roman
