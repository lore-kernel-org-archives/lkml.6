Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2429AC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE482086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="l5MLXdIV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DTKLumNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE482086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeIKUrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:47:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54392 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbeIKUrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:47:45 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8BFljQu007193;
        Tue, 11 Sep 2018 08:47:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=mbbBdYuVpTCP5kde4cWJR6CusFVeXB7Py3WwZJhmOnk=;
 b=l5MLXdIVVkgNCt/hCCKATLhAt6ctATrLbUbyH3Bj6+lkXD5r+KDYYH9B5t9mmf5dQDYS
 M+phqSzcLpcCKLLTivu0dwMPIRjED4xyhBL/O+AjMvqkL7Tu4D8JMiVwF+BU6iP6S8yN
 aVM0odT5uuleeQg8TvxAX3mG5MJ1Dav7lXE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mee9hredf-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Sep 2018 08:47:46 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.21) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 11 Sep 2018 08:47:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbbBdYuVpTCP5kde4cWJR6CusFVeXB7Py3WwZJhmOnk=;
 b=DTKLumNYayMKpY28PyaIqGGY4qimIUUM9gx7V33kn/Y+yq+5MSvmfjR0fBuM1GodsvsOTkJHySmeKTL/PxrTPkaoQv8MnCp6qLJLutiY3dpd1g053GQg0CCZGXuiKC3WaY6mR5fEXYO5O5up5zNisEYBa0Wm1xcJrC4IySAktyc=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::7:f329) by
 CY1PR15MB0170.namprd15.prod.outlook.com (2a01:111:e400:58bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.18; Tue, 11 Sep
 2018 15:47:40 +0000
Date:   Tue, 11 Sep 2018 08:47:35 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RFC] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
Message-ID: <20180911154735.GC28828@tower.DHCP.thefacebook.com>
References: <20180910215622.4428-1-guro@fb.com>
 <20180911124303.GA19043@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180911124303.GA19043@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::7:f329]
X-ClientProxiedBy: MWHPR1601CA0019.namprd16.prod.outlook.com
 (2603:10b6:300:da::29) To CY1PR15MB0170.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e622708-e6da-4b71-e19a-08d617fde82c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0170;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;3:SDOT3L4LlRTwbMEDECtUJ4ZtwyIolyX+o9sh/DAmQFyBbn5gZIFQ8iZ7K25bQjnkQFxSFf70z6bI2NghgcxO22vOjUW3aR+tsfo+VaMA3zzlOH5ZxBOaej2DxUBX1xcKsmagf3giGZN1z+x4nU7sfmORJQCWQBsKUqpi+ajb0VAtSiqOQdqPn+t4yBw6aX31QrRd5Iu2q74ZQwR3cOJOnvRobmX//j7K07WzlzITjpERf7bAngzqju1dG4NNTmN5;25:nZ8+Kkdr2iyJQCLffbOTS47xaIGBSYSJB4HSiaBn9RDDIgZ8tJC8UtpJSXo3bmNiLg+HFKXMjzTI1c92nB5YoK7vrPggXruf0KmYsfmQvHgb3cYYrVEhqqvQH1VWjz76GAODbnzci0klJeLGELDegx1B29oW6S4flMdBF9GL/BURHoD/YiQ1SUcLgDpLU3q9RTbzHg49LrhL/8pX2ePZ+UuLcfjPHwhj3EDULo+EIONl8c4AKBdJq+br6V2naFwY4h5BTiIUP4xEgWJlFm2fBGkN0PyL1Ur7E1LZ2DKQpXe6Zyw7MgcNqVbFciPIAxha5n+LIE1Nbhd7gyZlwgfNAA==;31:xLO5ULFNeE0+OsI8Rc2JDIBXDP4mvn23uTO1wvnEKbRI9bhTzcqwakNbGciGo961T4+0rgTAuE2pVgeuTvaPf9sRgp67FNDGKrLl4z1i34X2n3xqaWfM58DPGO8gM+hrG5W5j/5+hPDBzQYWoPIyQvvUrWI3GMwtiS5Yt37ppHkNlNyFfOBCQq66DuxGuTYvE1Lf/srDsL2VzvbbjG6l33m9znENHlUQ2rC2GxcmVqw=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0170:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:fSuPMxptItzga3Xkf82u5HHt9mHq1Su2mLNvisUU4PXqtUcsNHJGDevBRG/t+svjbW3jXxnVwpiSrhmSO1TqHldyBhApi57RJVaFdBuSCawOAJGzrGeh9tlyP6UYNZIPvjrSXPa8+o7KjNRI2eBqH0VKli1wF9BKlIUgauL39oYbBW2LfyLhP+gT+AAMEx7rN4d/2q9Z7eo3QxxS/ubPLrM4+agzpnf81Jo7kEWvW/3PHEbCoR3VTF8htNQO576zSil5OmOMN398WIAOofYcstRIc5sJf2A719VCajBBEtfDqL/Ux7GweWJ5t4I7Tft6ux5WMyJ9EPntQhZ3FqCPjKdmvQv7eDoTb8OfmrD2xXGOzI66cBfyB+KJK+ZwTFI+KcJ+pGMeEgMu2YmU8GnanYZsqS6ypHI0nzxjH4KBTLxzqHqFGTyDJuQXM+BDaBKjezIBXCeI0JjSTNffWHjdk2P+DFPw1oeWPd10nz0aVDaZzZRYEKStBx5BR9SEbRzI;4:qLujAnj5++7rIy29JVvmWz1h4iD8YsRRFpWux4NvJeBveD+hkL5j1Zr5MJLAciN08Gc50ewyp63Sad6MqPoULk1jy/uaNU4v4rYpT/snOYM+u1Uh5+T9PbpMNzB3FdtxFgKOmS+goRhmk0QlYqXZHtXqfoPzDJKK2u2JnIS1hFynTbsM94b+BqJWfRehnHsUZr+Xd5d+25/0i7gO+2bEeMxRyahikc/PdawXSVF0hq/KHWwba9DXq2ALk0rzZK4u7F72CNNPfpcY493GlXpoFp+aTBCi8eL3sj4UkEnwEAFamXJnpwbzB0f+cYgEN70Z
X-Microsoft-Antispam-PRVS: <CY1PR15MB01705678910700D5F26A937EBE040@CY1PR15MB0170.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:CY1PR15MB0170;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0170;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(366004)(39860400002)(376002)(52314003)(189003)(199004)(52396003)(476003)(50466002)(68736007)(14444005)(33656002)(76176011)(52116002)(7696005)(2906002)(58126008)(8936002)(81166006)(16586007)(316002)(54906003)(81156014)(25786009)(486006)(6666003)(5660300001)(47776003)(8676002)(105586002)(97736004)(39060400002)(53936002)(6246003)(46003)(106356001)(11346002)(4326008)(478600001)(6916009)(86362001)(55016002)(9686003)(446003)(229853002)(6506007)(186003)(386003)(7736002)(23726003)(16526019)(305945005)(1076002)(6116002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0170;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0170;23:khdD5Fr50b/OPr5U8jc32gfTwJeWLrs+Hd+8vfTR7?=
 =?us-ascii?Q?2AUrZRsAf8lWnlkhqtDRgNifvnrCRgZcMEkqmdlGiPFY++tdmSSi57GNEW9l?=
 =?us-ascii?Q?BjJiy2vhSiKds1425ejWVsGvgQCWCuZPqV7Y5ls/BvvA0exd0jJC25zMHTHE?=
 =?us-ascii?Q?fBCJgzeohY27U0PpslpIyFlzH0GUMnlAeJwxAQVb3R668wSq9U91vx9fL1n6?=
 =?us-ascii?Q?pCPCFd8Bp2K4ltXa5R2ube4DjBL5b3N243mDbsoJPHJXu0GedRjivQz0qaDD?=
 =?us-ascii?Q?lizLzfv9KmEsvwqQExGFd7SOp78ue88gi7ATTwUDhpp5yPSwMiFMLlF42nVs?=
 =?us-ascii?Q?iFNXNuNaqUNyKdH1O0QKvDNKwRbEkITvtyEK7O8z7/FWkMPfWPXbA6Yv0GIH?=
 =?us-ascii?Q?JnAU7Q/+ZXmUf9Kvbt8iY+xKrbxzXvvvCX4UQnYLa3fvriM3ZHav624BoQEu?=
 =?us-ascii?Q?ENxvqpuCMbbqhYfNB4sgCY4ekpabHzBYh7s8O0x8cNmAgg0EgQUYEMWOISjS?=
 =?us-ascii?Q?kOmo1BNsPA8AOwjdJk9snW8LhvjaV43y5lGSAhqGXe0w6mP56EnJg2O942ld?=
 =?us-ascii?Q?gWYYVpGFKeCZhPusDBy/FSugXjFEKUm03GzwJRa/pP9+Wi9dcdHUPIh4sN0u?=
 =?us-ascii?Q?pIc4bF2ngMIZ4HofsjYzW6MSAKHXuKgqpLiVMkTInLsNRZE9achzNuGSVmRA?=
 =?us-ascii?Q?1AxN5vK60BgFrqwfmHOuoaQ08yC0Rcsp7nlFgC5Gipxfob8X/fdSfu+GQ2tP?=
 =?us-ascii?Q?I1wZmQTazUum5ESp8Iv/VFdeHjDKKibPlOR/lOmMtwJCbV9SAtcNtXiV0KiB?=
 =?us-ascii?Q?V9RW3WtVlvQf5U/cjd7p2VNdIy36IsCLryevZjUG0UezPVy6trjvAYpBkg/3?=
 =?us-ascii?Q?iNvQS2clE/ndMccD4UsgwU4bLZlszhuuXyPtvc8HqYuV66mUXQObdQBLDMnG?=
 =?us-ascii?Q?oDDC6pOWtUkAWSWhjMMn7+Ju6pQ04K4/hSsTkLTovkzRYm3zA90wuWtGt7JU?=
 =?us-ascii?Q?UjD9dlbDIx550QTemWApiNSa0uOowEqRJA+GF0TZ/VDHOU12ek1sdSnTn87S?=
 =?us-ascii?Q?ME6IVUXX54acCBW51RpTP6rR5sa//ZR+xTg0rX/PyiERl54cKVOeZhzJ5fTO?=
 =?us-ascii?Q?jXA6cdrwdkUz0iXtLEu6BdLUZDi4YOiUGWkfol09/Ocy4vt7SB6RQRpxZHrg?=
 =?us-ascii?Q?k7Qq0slYVSkHVY6gpkB0f//rhXD7TwadQkz2iSkwPeRkXJ74d8D6zgAPzv6K?=
 =?us-ascii?Q?U8vwzMsPrlgpx8yDZgh8tMdTCm4T7UB4c2CBleIjJ7G1ELbFgMqKA8bzQUuR?=
 =?us-ascii?Q?IGTyZy5dx/5KAfnLu6qKEY=3D?=
X-Microsoft-Antispam-Message-Info: 6jPMpA7VSmk1t7auaZYSy+4agrcGuqu+FmQcMvsktz4ZNvLgHWUOcwULt56I8tcOsTG7wWrhP856EyEXH91rCDx2JwuuIPQynHD9RfQRu/cYtVXCiySWA1XDBveJu/ymZrAqQ95yoh1BchbeNSieWfqJtr6ut5cQWRFC4/lN7DwJTmNfFWqdMQMoutkhGhxbR2u/dCgKQfUTpzLF60Mb8xX1hreaEc3Dvu0k1LPuE7iRkUjhAWFGqaTDAyInhNDEAwZwzUIBgRCs5oIC5T4SgCcsa3CTE734i4FUuvyIjEcHBPg/ohMiiChGs34c8ncmikxtkuW+wTydSeRRBgbvP3heF6zlD6MWYJCWktCp8/8=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;6:XoLkdUUww6FB8MyVsG4Pyy1MWtpmcYZZ/2yTsrfybW0ljvTsUimMcA7TWoc7kwRTG0Mgwxwgx/32Bjp6PcpusOgUMK8GfPmU/5RhbnQgXFkKQ91aPtCITNG4lhQW7DLYYEaYlDxCFxL/utlqUkcysis0GfXOiVt/41e2DsyYagXXai91/NJeUgyiDS6UQmlHfH2NISAuw43ZIUjGeQ4vklDvG7/SKaxAiDB5o8xuSd9GdIF2I/9RIOiiSKEshbScCLRmnWbqMk3XQAFDdBIxvCeiK65YXCcNYgGMPhqPTw9sjsEanBJ2GaFiGNrPIllH9AFpN91jYvzPYX6BVjjVfMyqfP7wapqiYen8nuFnAg691vZ0iQYaCDOelJGjDmMEjyNuLDTZfFbRRtzIc0g+oFi+0YiYRmyK3BMfeQxQnCEejbnkYQp9IMTQNa9We4xZLwk/ZMS0jRXvwGGe/fO9eQ==;5:M243RlCgAuSRG+9d959898RlH3czFGsq7ix1vFBwYRnIoh25vStnaBpM8TXVYMiQ6Q/ntJRTKOlnoa0cliTR7jQVq+PUeDdkEiYCT4+cRiQVnaYXP7dbX07QxW+zagZi7KbKOolLtamPZLCbhqTaxt7UE/Y/qoHsNu/PBdEy15U=;7:Gwhf5l+17ogKXEpVhSMFZfz2pak5p/8cecUsBHKyLHNQY6MmkR+tvpR3BxRSpIsDgDFwt/GB3EP0nkAP5TLNVNZZLp45SZ5d4PJf+czk5moz+fQuZKiLWMHtixH2v83HLRS16ByjXsJ9f3l5fEbjJWDB+OHzKy24YLvkMQRgvSRQMUb5EwtNBuiyykXoWR3z/VOb2NHXs4TXGawantID2BMwEKHuve1JoitZDla6TOruqaV4KLwVS8DS7YKZvsYJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:02BzB7LFOAvoOKEveJAPR+S7qmqcBmOExjUuQIcd1GI62+Syu0YAJJKTCPbW0Tx26G4UOJlO2CvTqB5UIiIWi9i5sleCcsPaB8XVuYPWIG5m2JBvCKZfk4dWVikgrGGRTOzllC0uwSmTU1jbykY8uk4WhL+Fj2uP8a482n0d2Eg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 15:47:40.4300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e622708-e6da-4b71-e19a-08d617fde82c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0170
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 08:43:03AM -0400, Johannes Weiner wrote:
> On Mon, Sep 10, 2018 at 02:56:22PM -0700, Roman Gushchin wrote:
> > The memcg OOM killer is never invoked due to a failed high-order
> > allocation, however the MEMCG_OOM event can be easily raised.
> 
> Wasn't the same also true for kernel allocations until recently? We'd
> signal MEMCG_OOM and then return -ENOMEM.

Well, assuming that it's normal for a cgroup to have its memory usage
about the memory.max border, that sounds strange.

> 
> > Under some memory pressure it can happen easily because of a
> > concurrent allocation. Let's look at try_charge(). Even if we were
> > able to reclaim enough memory, this check can fail due to a race
> > with another allocation:
> > 
> >     if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
> >         goto retry;
> > 
> > For regular pages the following condition will save us from triggering
> > the OOM:
> > 
> >    if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
> >        goto retry;
> > 
> > But for high-order allocation this condition will intentionally fail.
> > The reason behind is that we'll likely fall to regular pages anyway,
> > so it's ok and even preferred to return ENOMEM.
> 
> These seem to be more implementation details than anything else.
> 
> Personally, I'm confused by the difference between the "oom" and
> "oom_kill" events, and I don't understand when you would be interested
> in one and when in the other. The difference again seems to be mostly
> implementation details.
> 
> But the definition of "oom"/MEMCG_OOM in cgroup-v2.rst applies to the
> situation of failing higher-order allocations. I'm not per-se against
> changing the semantics here, as I don't think they are great. But can
> you please start out with rewriting the definition in a way that shows
> the practical difference for users?
> 
> The original idea behind MEMCG_OOM was to signal when reclaim had
> failed and we defer to the oom killer. The oom killer may or may not
> kill anything, which is the case for higher order allocations, but
> that doesn't change the out-of-memory situation that has occurred.
> 
> Konstantin added the OOM_KILL events to count actual kills. It seems
> to me that this has much more practical applications than the more
> theoretical OOM, since users care more about kills and not necessarily
> about "reclaim failed (but i might have been able to handle it with
> retries and fallback allocations, and so there isn't an actual issue".
> 
> Is there a good reason for keeping OOM now that we have OOM_KILL?

I totally agree that oom_kill is more useful, and I did propose to
convert existing oom counter into oom_kill semantics back to time when
Konstantin's patch was discussed. So, I'm not arguing here that having two
counter is really useful, I've expressed the opposite meaning from scratch.

However I'm not sure if it's not too late to remove the oom event.
But if it is too late, let's make it less confusing.

Definition of the oom event in docs is quite broad, so both current
behavior and proposed change will fit. So it's not a semantics change
at all, pure implementation details.

Let's agree that oom event should not indicate a "random" allocation
failure, but one caused by high memory pressure. Otherwise it's really
a alloc_failure counter, which has to be moved to memory.stat.

Thanks!
