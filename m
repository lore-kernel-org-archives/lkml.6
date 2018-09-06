Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3F1C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FD92075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="O4d+CvlK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EIH70/wE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FD92075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbeIFUfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:35:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46134 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730254AbeIFUfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:35:06 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w86FtNQn011711;
        Thu, 6 Sep 2018 08:58:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=bps5orUpR+/RBJ87KL2Sg7kgYQzqEf5hMg1lOxIXlb4=;
 b=O4d+CvlK++IcJk7ejKrqI5AoKDuX505fdxxhqQXII7QHEDRe9GD3DCw6UJl/1m8OE80n
 JPrmZ4gq/bNXEBEDRVAvSCHOqdmuVyUfQ9nYmjTt6TF1MmLNKcmxueJ3y3NpKLomozbu
 lYbO0cJr11dQJVaFW0frqaArZEUuCKd1m44= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mb56qrd57-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 06 Sep 2018 08:58:45 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 6 Sep 2018 11:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bps5orUpR+/RBJ87KL2Sg7kgYQzqEf5hMg1lOxIXlb4=;
 b=EIH70/wEcqEmboItj8pbf4Pp7ap8W1uARklS9BOr9aXqzdg0t2Ph2WUtsG+RJRwQIktLNeF2Uh0M+/5MJ8HqB9eiGy2ji3ZU7xVDDK7mVx7Mov/wJJsY4CaKF96wvmFXmcJyqFNaGUurl9nEJvVpqQs0n4WH9SA0qVp/a8kJmTA=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::5:60b) by
 SN1PR15MB0174.namprd15.prod.outlook.com (2a01:111:e400:58cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Thu, 6 Sep
 2018 15:58:18 +0000
Date:   Thu, 6 Sep 2018 08:58:14 -0700
From:   Roman Gushchin <guro@fb.com>
To:     kbuild test robot <lkp@intel.com>
CC:     <kbuild-all@01.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>, Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm: slowly shrink slabs with a relatively small
 number of objects
Message-ID: <20180906155811.GA25424@tower.DHCP.thefacebook.com>
References: <20180904224707.10356-1-guro@fb.com>
 <201809061523.HXrJKywf%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <201809061523.HXrJKywf%fengguang.wu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::5:60b]
X-ClientProxiedBy: MWHPR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:301:60::15) To SN1PR15MB0174.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20b8ad08-4eea-4528-c126-08d6141190aa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0174;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0174;3:3ctzFqL5JAZES1oC1zkQ2uKFkqTupqfdO1q5EPDoTH7UmfIySgkTklFeT8vy21KZZfgQTHnVPbxa0BLTG1g/XJbTiAEhqoOHZj594/8h/2B4FQUvx2HGrxkOh6TLKm91mmwzAl69EE05MWWf/SaHc9qBk0+G0TqLZU7tcuYSR0DszXNhO2xQqBs1kj/ztciRJU+dQtEPDwZQwFcG9gDa81j/DlIx1/t3iWzqB5D8aIAtg/GdZHlM/QB4Ypnvz7Jh;25:4rsr6xwNEA11vCqcrObaEGqCxB6u3vhSdPmuZ8utUgnAelGWIdXM4mlG8woL+0gBsF3b3K0yE9i63w2HV6Ki1r2wxkOA9F7GAhpLBc/B4e2Ls3WaZdR/oKpAGexAQsur18sl8H/JmUr2AUTfoeUA8/oQgw0wJoLAQcB6khItamC2+8DdL2l463QtAUQLjqCU1jOGv0oKKIQOevLaqCY3tiK9a85w64XyBAXPVXJ154O951EKhtTshtkEA6AFzpxzC+VxEsjLJTBaratHler+lDEEkt3fE8aQzLKwCMw8/Gs632YuXvczSJutahD1gP19bpwwkNJynYRgUaXJkuOndQ==;31:eMhaZ7Q5mh2zNeATiNZlfvpZKPHAb6rJqpW5VVJi0P/TzmF3bQgfztiHPyDwgji+WhfmjfVbVM9KHEg2y1eowadi+Ta3qSu8cUb/k3TFrH+iuziE04obmWF001mwcb+QCWkABEU+X8ixTucHlYr4CF14cf1vWEtPJpHMxnTR/uZ7AE3YxP4Rjs5lEi4AQaijsKKy3dJa6LqD08a6iThS7ikFrMaSyeWAfvl5ELOMG64=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0174:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0174;20:0KmDbJYDCFDH3cQ+tnGpqi6Hn88RIov37m8VJNzQ0PK8ufJNGkxj6lxQMfIf+RiSOl+bq1VL9rpjYIy8MtCKVEByWyQXZ6sT2mIVmXI/AiNUr+rp08uWPKk5uZhaNfrFboFxx3zCum9h5OF39YyDpXvhbx3gUaL0+ULBmrP8NOjWzuy5O3QbaoKuimjhyMF8nP+mCNcKxS/zZK8dsZF4GsYmSyrJBEqROJWhi4kAi+yHiE2ntF/Mz73tNAP3hsOavogas5/CId5QEP+GCZke6uKBUVdcWMlAsUfOhbeWJPCu2Spt5sSiag46KHeDHEDCkX8AFPpbdxZuo9q2JQ9s3w+W2OUo3M2BLU2XN53eKYZI7pPqWol9obHjPLmoZEGuoFwXhWqgQRFb3R2vrYjNe0ogsRnPR5HmJzmj7O59NuwJm4wxOva4/NKZxPfu9Mt10BeCXMKNYvTrk5g/XvyQAnz2dQ1jU5V5UT9JVWqr2fSvGwaQAaQsfaXIPgDfbC6C;4:WETzJ/zohudzbJrJWmi7BINg9vFciPI/fjtlTg0yo0qdqSkZhime9Lfo1XkdsIxDthzf5OzY+rPL2/lytzKR3yuJHU/llpYR1QEEEn6e7U7o710XDziqf4B2KzQFe26U9wC1V5NFPBlxybjT8v30Hhedm20/Z1/LN56qOrLcMLy9xEQvBBuqIuKpjF0iCZ3kbLC82qhxX9Vj4IorUmYfUUm4b1nb+lbDeumSSXmDJ6SpUEkGWVZ1B4U2v6MZpDiQFJOlz4Eqpx81RgIYdei/DQ==
X-Microsoft-Antispam-PRVS: <SN1PR15MB01749ED63991C082A7DDBC4ABE010@SN1PR15MB0174.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:SN1PR15MB0174;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0174;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(366004)(396003)(51914003)(189003)(199004)(229853002)(478600001)(33656002)(446003)(476003)(11346002)(6116002)(52396003)(186003)(6916009)(16526019)(486006)(50466002)(55016002)(6666003)(6506007)(5660300001)(386003)(97736004)(105586002)(1076002)(53936002)(23726003)(58126008)(7696005)(106356001)(54906003)(76176011)(2906002)(16586007)(316002)(52116002)(68736007)(8936002)(81156014)(345774005)(8676002)(46003)(9686003)(14444005)(6246003)(305945005)(4326008)(81166006)(25786009)(86362001)(47776003)(7736002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0174;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0174;23:U5OiamjvjOTFsDBx1CRqIYeauBihsT4YxzR7unA9Q?=
 =?us-ascii?Q?tIdTfUOOmbTEB/gcVK5N0saTqteUmPHgJxBGxQSb6DgUgW3bHKaZWAhEZdJK?=
 =?us-ascii?Q?R5xmTTOl68NxSrTQFBwt3bVHuKCPCk9/MDCe+yisUOk0+uEEBUZC5EV9hk4c?=
 =?us-ascii?Q?VPRMj3nUMV+1nwN83XSh0rPI4p2feH19dPD55nQRDy+920on5O51Xctz+RjI?=
 =?us-ascii?Q?l9gPNy1K0+s6WV171kn81GhRBVuGesQFU7Fvzs8JrG6lEMej7PnKq5ZbyZVD?=
 =?us-ascii?Q?veSub6/Ig4AVtXFzMu1DVWuGA/h8VTdhazd8IGCOz7eLhapLtZAOJHzYMcdI?=
 =?us-ascii?Q?bUdf1v4qV2BoNqt9E2XVHX1p+rwfSRDO4GT6JNYfVAsc261Ofqfz299kG8zu?=
 =?us-ascii?Q?OtpNyRj8MmOK/oD0PVnQr3NlqcYCUj/5vjQ9X58n0++iCidrnqMKbHxYhk3D?=
 =?us-ascii?Q?sy1ehttM4XWAPZyiKdvP/87Xn1SuyB7qqZLQTLsI1iFmM0Tyi55SRELM9Jz+?=
 =?us-ascii?Q?lRRsVpHam2KqUH6vb67p+F33FAN9ER04/DUTL6lqsM1JU3ddgn1G+8ejXuj8?=
 =?us-ascii?Q?eFrT7SP+EmDdJV1rWdFEDloZ2WmXNBq0nprZQiDeKzx4FMsRPW36M5gc1Usc?=
 =?us-ascii?Q?bLQZJSeRhTlTt5LxBrFcB5lZ3LOx2ITqTflF1QXtNPx86LlcTPFRk7FLJuxG?=
 =?us-ascii?Q?pCkAkzzbOawW8Jv8/K9KcYaD5quV2O57LB2IRum8blcrbYnBD/tSUfWJnOeg?=
 =?us-ascii?Q?JXMtm4tHuwC+bCOyKesPZCvuzW/TjQcXMscG53i+lXQCYd24z8hRi3BjONv2?=
 =?us-ascii?Q?39OxT3dFORrH5WylIhOP8Rvtq5k/NCp4MRpG6ObHFBoQZm0ZjNLugvo2w4dH?=
 =?us-ascii?Q?zSBVRfC+S6JGqZHasPIyPEm6oHVHCPi5kXEICdKvn/gZO2n+/wKh0LOMQ94S?=
 =?us-ascii?Q?K4MkeaELDlEeJywOUX4wME7KUqH8+Ug59ic+01Z9QZhSV8hMS2fp3ioeKmZe?=
 =?us-ascii?Q?J+e8L3n8Fa5FvaMqbBD1GPfRMlo5gC45oTi8WzLy0EqsYdpE1SQll0k6nbRk?=
 =?us-ascii?Q?9s9S5D1DhrRsyPA54arn8LlgqXp7zbjz4DVI0x8nTO1F9BkppuqN4qUA3/Ip?=
 =?us-ascii?Q?gTSel4NvwViQ8RQ338LyRCyxvMrcsqQ8SELiw64ItfxhxYdmw2hDSTe6IAFI?=
 =?us-ascii?Q?YgWr+OoMzi0TfjT8IlCdBKeu6R7M/raIJISEOL42wY1rLMIPzqWdOzrCHQYA?=
 =?us-ascii?Q?QhJz8c3j4bjaPAuEcUTCV4GDUyVeFzYaEHIHSkKEFBVH6HdxqkTtXc67+YkL?=
 =?us-ascii?Q?dYkDZALsXApcF4qTpB20lw=3D?=
X-Microsoft-Antispam-Message-Info: gBbkph4v++lwEKuwW2ovCr+k1kAU8EWF5Z8x+JABLiJBmOzdRNGBaXQ0BgEW5oCZN63WkqOGmzr3SQYKX+t6o0Ike2M2ZAADsOOnOwW+AfcRev7MlMIVmr3TTjlgQDdB20qnIHQXZz2ctAlgVRjUOr+AmH40dZ14WzCzyFgqEVPygeITRFJ1eLqfYwHnVJkWiypLizJ+v0dS3fofqoJxfdOnwdi4uLcKX2KrTsGDzOMMV+Ip+L9wozElqDV+sgB16pgVCfmUfUGUum1tVLB1IytVtf6bOb8DwK1A8vaf0/peo0iE6rvhdT5nxg05brFHmcmvjkiaSqWmg4vbBt9XHjpYLbholoqnH8xWWdIlLgU=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0174;6:DvJqwCE85cmgjZWl0y/KCPed2/k4XvjUBR0HIwOQzEMjaoHOKUnMFzh4AjNmxe5r0WUYVj1ewbo+MIeI4is4RzufOh9LAXwFgUKPDwAO7H5Bns4jI4sDJTB8LU6ALBGjDT75zmhgkcPQxitTeCweIVHe+nZl3W+rwRXisUVoBt/3ANTh0GrxRHzN+aDL+pAIHrx4mGO/SHIR4Nq5Ke1wN1jWZqKL+jI+OXncQdcRsM5slHQ8jg/3L3ZiwEPqD5+nTSqpfIflS2MQb8bNSkbv9EA1ZhGiW5DybgMv5/0G5TNlcmsplp5RxIhFWwbqE4hRdFNE/u7fFFtLDxcUWaXWIvVzPpfMzc4o0eRX7Jr7fqZcCeIJfM/zs6/q9iUzZuBc97n4ZHzE8JhDwojF/wXlnmEoxp4Muu1dlECCrPKzRfV/Ju2Dsb4aj3VnJAB3WjjRt3KucAs+7rL9Ro9RYZlKiQ==;5:W/la/TjYfH1040ZEdLRZKD27aWXPjNLhNXN5jiLsdeCm53JQCi1gzI9uI+md2EdUuJVHwvv/zE8P+0vuUbuEF27N04mlwlMX4Ix8cLFZgv4ns/veJXEaYkXHi90B2GaToGYH/34W6BglFeG6XJG8GWebWumE4JUfjc65gHEx00Q=;7:rXSVYt3nwOdQ38cbZnUD+v1U2ZCL3MtVGg4c1KQoj9bQ0QUVZCmuRBjCFIjehxA25kLKowwGDspiU/4RfJhiGsHCVKZqh+aG6fMhtlqEX+X12yppwFCaRWbje5WF/LNwtCrIaio53V+D6CGjo3S1s8jbSB0PzOghC6LSKrwzON40pWUjslAuqgGStPA6F2SOENR0NT13agNRPodUMuwryz1OFPY7dKRnCQ55k0SNeZw01SJ+KgYvo8M4SlVwxUCZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0174;20:09WZxWqgppf/5fN0DxDyYYdA1F2Cf27CW0X7QtdZIHo8Cu6vJ3E2FoF0PKio0ssrQ5hrW+D0wQCI/NIR/hT9fmzuCpHJZcpwRbFIk0AO9iYM1h1uXzYuEu+EAWnNjtdqZqe9VykGfqmcB06hbvDLd26MvtU6OzGDqmSW82M4+rA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 15:58:18.4706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b8ad08-4eea-4528-c126-08d6141190aa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0174
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:42:07PM +0800, kbuild test robot wrote:
> Hi Roman,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.19-rc2 next-20180905]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

Thanks for the report!

The issue has been fixed in v3, which I sent yesterday.

Thanks,
Roman
