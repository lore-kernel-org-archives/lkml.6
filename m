Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F73C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03452213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Fuyosn1n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Y2F1Q6B7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03452213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbeHOUJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:09:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59056 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727604AbeHOUJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:09:33 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7FH53fd025327;
        Wed, 15 Aug 2018 10:16:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=Z3XsjA3uq+Ih9vIkLFTDGXoAdhvZSoZdeBd6FcdaUi4=;
 b=Fuyosn1nPSgj/nZBRcGdyP37ER2t5p9XrfMSCfW/vHXBRrgMENjiA2BUs3FDJ/sIUe+L
 pjN7Bwh2mx1SJiwUJvNXPbLhTdUyslQ3K5Voreyy8QiGNFNR3JOT2SajpEB188gYnhfW
 7Agyjc9xjG24S09Oh7O+Re/kwp3qVSZIO/s= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kvp5w0g82-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 15 Aug 2018 10:16:26 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.34) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 15 Aug 2018 13:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3XsjA3uq+Ih9vIkLFTDGXoAdhvZSoZdeBd6FcdaUi4=;
 b=Y2F1Q6B7BKm3n8HyI+m2dbAZhpXVKjiB8H3CwqIjE1TUgD7lBSv89MPNTMb0k1yMU2fNtBEQbZ5jtaYkai1fSIPlDcTtIq9G9x7mJYCKK4zEE/11nNQ1gDhW0ObHa4+/PQ4yzyL9vW3Mjh/BEddB8LoQCheQITPp/IB7jEW0EO0=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::5:abf7) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.22; Wed, 15 Aug
 2018 17:16:16 +0000
Date:   Wed, 15 Aug 2018 10:16:05 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <luto@kernel.org>,
        <koct9i@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 1/2] mm: rework memcg kernel stack accounting
Message-ID: <20180815171605.GB26330@castle.DHCP.thefacebook.com>
References: <20180815003620.15678-1-guro@fb.com>
 <CALvZod5LW_vCNbb6=PartjujnWcOiYbaAiANR_g+Dzwpp23BmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod5LW_vCNbb6=PartjujnWcOiYbaAiANR_g+Dzwpp23BmA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::5:abf7]
X-ClientProxiedBy: MWHPR22CA0025.namprd22.prod.outlook.com
 (2603:10b6:300:69::11) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 177280c8-5bda-4055-c7b6-08d602d2d01e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:trQQPY96uuw/OPLbLDLYc8T4MThrF4wSfuN+rOgTjFgixzqqBCLYeoWudG/oppqsp0y0ryifYsjmDPegF7crl7q59i8nO+nSkn4AU4UCRSaGHbNpv9urH7FfhnRkYnEEpURhJEvVbnZ3qNCuqIIYNIEFKrSgUg/5Q0JCR6hbmpXcwdzEnbrYNL5xFwk45eeXIZjzikejqcCH9i7SuzGq46ciMI34OI0CjikMhE+mN3TZAiLVLYEZ8yyxCJ7y46q9;25:IKyoS9GpRa8wQUP7B7jpC2rl5B6OVW+Pu541w2dlP56FYiRtcd5NiFxGxMe+RT2jXcW9qIoq0/eavmQvcWZzVP33VOri+WuCf+G8v48LF31cDrTU0wUCogpeO3Pzdr22zTBxkgCV3rhadJuznQYJ8m2hb+cBeY/FS9QEG0NR1mjq5kad6J0ckmCtVsWvxbspZlWFJGQEpbLyMMCz6VTnLpbkuu8vwULHu/oUM3dvExrYSrepZuMfqjQyyoIvW7KBwIjvTIRvIVSA3TmkNkWDjjcMy9zbNcFPw7NCmLR40fjLa0tHaqnmYhI42wPnu5io/QE/B8hdgj6YHZMjAWTUew==;31:3osjgCcBBJM/DjicgePyRRV/mcYGd5X+ds3MdCtgHT/1ERd4jEymoW0y7yzy57UUFiksk6ZqIfKMJxv5dX7gaxUr3yUdinQde7eAI3L35RwTXMTdrIafsiMLUrNU6wE4AnFyp6qyWLazhrTdfZ/K31Li+N76Y5K0D1yV68hK5LhQZ9ZKCC9mJw0iIzdvY9rpSSTAeOyauH9osbTn2dVb8dZ1vX2oGwE+8qrLEQ+h74w=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:EUpAwyPuSyDpxLlm7fKJkj8iRXhWG6tObbNJ5nLdEszd29Dy8jy0i1ZuAHQ+zZE2x4OV0OFR7JKxiCZkFkNdv6TSaJYPJkRjHZhHis9l2U5HAokeYQiH9xmlh4OSHr5cnqbNnXGEOvY6KP8BRB/kdSZowWl5uX2fM+9GBs96uvquct62uOk2NIodZEkiZgR0nDfvXZIulEyQDn2ITEzhs9yGaSJBcZHtYbxt5ampQ9Tj137Nb5XDxvRKJZ4YAeFc+dIx2shbs6xTZKvw1U5gBjnPlXEhOcZBFXL/0DEBH2o6rYTA5ZjuVNTC/vLiISpsU6dBV1c3EfYKjKF4Q8Go2kEgHIQh8j/sFzaGzcH85yktnjN4tGVMMtKm5356D3euIoLMIGXoB41psS23yg4cdRotw2pjDpFTct/MylILTMcLMsbaDsqk3ds9w5Em6UpOexKOS/CChzB7VPavr2Zq0eeyKXB4YxbIz0wPFj59F7In+0UZWvz+pHuiz1OZ4Tx6;4:ThFkBmtzbE97FfCMVUuVHb9i0wq1OsIIpTSmCFWhWYUPCWlAy0HX4AmEVk0M2HHwXoDESyfWw/tL+tTCcOOfV6RKPUJQkcJyQSC4+JCjryjwr85KJny5SuEK/RfPT4PmehQtOxuW7ZQFle48qQLucErvysJ4phjAHQXg9CbUKLtgSfeKkUfRnMYgTSTmat9VGzFma+R8ZOUDd5gNTGa6adatZopatYKoVrKRicQOzm8iTdcvNSO3ivnB0sg+3njGKQsYb+T55W7RxtyXyznySe6NA25QZyVrT1rQXqGbBAjd6jj3JPNiqTKYd/roSQ2LcTA/RQCKPZorsFw7VEEl1UzbtkVDhECa3EGdyQOVBlZEzLfziX5Gd1WmAW6v1Bsg4XML0Z9cnNv0meEccdEO1Vz8iFLQGWxp4NCibxdjTJ8=
X-Microsoft-Antispam-PRVS: <BLUPR15MB0162D1882EA9E1A06AC6D04FBE3F0@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301033)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 07658B8EA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(15650500001)(217873002)(2906002)(16586007)(6506007)(97736004)(52116002)(9686003)(86362001)(7696005)(386003)(53546011)(76176011)(5660300001)(55016002)(25786009)(54906003)(6916009)(50466002)(186003)(4326008)(46003)(58126008)(6666003)(16526019)(11346002)(316002)(52396003)(446003)(8676002)(81166006)(81156014)(47776003)(68736007)(105586002)(23726003)(476003)(486006)(6116002)(1076002)(478600001)(8936002)(305945005)(7736002)(229853002)(14444005)(39060400002)(106356001)(53936002)(6246003)(33656002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:3iis7H57KE6igwvN5qd18IAFV6vYWwgOXU8took5X?=
 =?us-ascii?Q?96yTe6aD6eq+f8R9x4g7XaycEgpKesnhY9sVGP9Oqnfew3et4CkEZii798pL?=
 =?us-ascii?Q?ZdEef2urdEN/PXxJSJE9U466o+RQP6zLFJF8lYJhgIsDZKtM1svF7EenHWPc?=
 =?us-ascii?Q?G4Vv9t1PUYVxSM1JxX7Bl417ePGmY8Ga++8eQyaB6EJntn/cQdV5TOKMhiHP?=
 =?us-ascii?Q?rz+bYVc95RWxk7V7PZb0J5L4clUOzIUtESsGJhgTMG4y+2OGDClI9YKGOJyE?=
 =?us-ascii?Q?t20RlPuPki9pHB/IhxBZDY8DMnWFy4Zpnw3vwLP8gXranWcW22wZTuSWfpHY?=
 =?us-ascii?Q?BzMbNMhUmPmtn2DYrjcQu4cPAAPyFUH3Rl+xqIq1h6cA3fcOx01I40iIyfiL?=
 =?us-ascii?Q?02l65dc2mc6/tHScncy3Np4Drp6o5x1zIpwdH4Lnu+rrbB6RdqblqQAirElN?=
 =?us-ascii?Q?IMoW2p2NFk/S+5mGFRCfWDJEDxZzhWRo1YUeA+ReuFnIecvJVI2iQg74N36p?=
 =?us-ascii?Q?Ftb67H1XQqedCdxwvodhWHKNk9a5KSx76k5/iOy+0rMdZNgsD3g3x3C9VRN1?=
 =?us-ascii?Q?EErua8Wlhbgjnbds05jBqzcMh1fyZ0ZZpl8nt4hQJclkQgZ4CAICfkIVRYDq?=
 =?us-ascii?Q?opQu31KgeziquGTPmYLipqsTI69QePsyZEzTIID7k9FHqitYUYMJIcraujAq?=
 =?us-ascii?Q?gGCj3+eFw+vrdH3r8W2YXVas426nEwQvUemUZ6WMeSdPQuh6kLw6WS9SkiHd?=
 =?us-ascii?Q?JdGM4C2MBCNty59CANrZIRcXwkkxPCDT9CBL+0Y0h4v3YeoKwxnDX/lsBkof?=
 =?us-ascii?Q?yKHNnrtCr9FCPTbRl2A+jK+zpVRGoY02/6EN+FFA5EsVT1L/1c08qNI+ArKO?=
 =?us-ascii?Q?vv3LHYOYbaogDBfsXryHZcMkhVoDyLNVfZJ3LFidHW8ptxRrOKaG6bH/sIay?=
 =?us-ascii?Q?GZkGQgQhBrdKVZohTlQ0nzdNZKLuUMzHORBljEnCffuoMRxEyWOgRzM5i6+Y?=
 =?us-ascii?Q?JVQRW4tusl1eQtKq4M0+4ZEyaIqLxdjqdIBjbYRvp/gWJzhOx0h7aIPsVMHN?=
 =?us-ascii?Q?FxZAH+ExJpcIaP6rb3y6d99MXc2cxXfDgLWOOAM+C7IdBjLgh/LcLbI2IVzK?=
 =?us-ascii?Q?gJtoxd60xNbdquTVWT5Lwm9HIK/OJnDvBkSZqDt94furkT8KRG2nQpNQ437e?=
 =?us-ascii?Q?bLkbeaFY5ybMVF80a2+sgPxsPopux8jWXL2KNn+RisTOR2wRRE2mE6frPHNK?=
 =?us-ascii?Q?6Y/eyFh68kLP/Bs+cD8+M7UA8fHpkZjP7/Etw8n3QUqEF7oFndxH0vLAfBQl?=
 =?us-ascii?Q?uX9AacbspsC3oZrMwhPU1dClWsP2MPd77Es9Q59pNHMImgbGQRv5PaGDihXH?=
 =?us-ascii?Q?Xf+6Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: 3Cu2ndf/1zDVMwxXMVAZZJQr4BCbmLMjwd27AKFo5fry1tgOymGx6njfGtt+sWQ3sDOxsDdYyPdQdTeKRbGkdU5VQkFgnQfTHIV6FckGp84iWrqJwW5iyih7v/LfFy1c28xeAK92XZos5abfK427lDbpOxDla+L6GQPwonmD5Ljq/xZ15ZT23Gms2DueMvdaDZwCc5rdoqrCWiucWDDuXNJpIwEGrrqSc5QJFOb3MN+mV+21jlJzgmJMJO91jXzoybOXEyDKukv0XzzfDhtvB1eH5/Uif7gkyXScCDFqj12iHw4jqjHXC/a9wYYwW/c/YfzVNtrWM4drPKZN5a4iAirgf+d4nbOvrAi9uz+rVpc=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:LUpaR+AC4rMuA1W8Xm5kuEn8es0YOdMpxnNfmTv3PGr2LBRvLk/JZJ9kM7a29VeTgBhZ5zfLAt7M2Tdo+UviRogtST1PzNT1nBTphnMIBKZsZ02b+JbpvMPxO+Bq+17qz0NO/0KaAQQzShzZHCqPtA2VicO9mixLodKWivPkB8LPX6L7F7/z6Tv7JWP0NN9jAbQrT38f93CZyYK9NO6BHtgdfna4P3vysAgp+HPZa2146kjYKildqZ8JF0tNwphDkxELWg4oplfKqXyqku83DfIu1IbD/bHKJhM1WWxz00i9Z+9RvQhZEeQbEtmNM97pYJj/j4b+W4lE3Ze4LQGqoZ/2tT6KuWJvwWnVEBPbNx5m2x3edAHs5z/C0uXf2NE2AJDvd59nogBdfZCxEN57/TlYRG6dP2uxsL/0bgkatt6PNaWBYTIsfYpkLqfjTfwx6Ok14L6oAGRGf8O3i77xRw==;5:g50Zggh9WphgagbbwPBwnxlUYyjoY+V4n0KH1UsYUbHmR3nNt+CZ4Ho9myHIFGVTcrJqI/xNgmBkqGldUtFDgtjb7u+q7VZu6XyM7IpOWWbA/BHdBvOTLnOcrjal81/mlrarjgskEvT7kG7yABNl+m/p1wJ+fXetF/RIkij9uf4=;7:w3GCcR+YIQQlFMO3xBqTRppBes1O386ghKENoByNVC4mxNsMpAkOwmlLXiVe+VE9BRQGqSCveTXlppzOqgbH6TYCyffLJikNi1lcN8H9+H0ZdXSZQgUc8GgTswIQ94YPGOoT31RKeHJG+B+HCK4Jfy8dOVApaAQ/sU1agDhj4jceBly/4q7CgB/dujTnO8yCkInrCMoJrxaG1qnCm3h/mJjCIodFoO+2Lm4Gd+s0dXQKIqEMI6JE63QJw/aVessr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:p7HwX/C/mTaSA6ff2l6VxR85OcUSzK3HoRZHNcCtdCQyMYgOrmXFfBrK4Up9jPFQzEMMuYeyhR5XahlUJH4p4XzzTGb+PDoKoDOZyp00zc14+PNiFa/1Znms/EVXJo7bSoG6qPWnQABN1YBPhxiUh3lAluO5wdMEG+X8vM3abcE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2018 17:16:16.5139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 177280c8-5bda-4055-c7b6-08d602d2d01e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0162
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-15_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 06:18:01PM -0700, Shakeel Butt wrote:
> On Tue, Aug 14, 2018 at 5:37 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > If CONFIG_VMAP_STACK is set, kernel stacks are allocated
> > using __vmalloc_node_range() with __GFP_ACCOUNT. So kernel
> > stack pages are charged against corresponding memory cgroups
> > on allocation and uncharged on releasing them.
> >
> > The problem is that we do cache kernel stacks in small
> > per-cpu caches and do reuse them for new tasks, which can
> > belong to different memory cgroups.
> >
> > Each stack page still holds a reference to the original cgroup,
> > so the cgroup can't be released until the vmap area is released.
> >
> > To make this happen we need more than two subsequent exits
> > without forks in between on the current cpu, which makes it
> > very unlikely to happen. As a result, I saw a significant number
> > of dying cgroups (in theory, up to 2 * number_of_cpu +
> > number_of_tasks), which can't be released even by significant
> > memory pressure.
> >
> > As a cgroup structure can take a significant amount of memory
> > (first of all, per-cpu data like memcg statistics), it leads
> > to a noticeable waste of memory.
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> I was also looking into this issue. I was thinking of having a
> per-memcg per-cpu stack cache. However this solution seems much
> simpler.

I also thought about having per-memcg stack cache, but it seems
that caching 2 * n(cpus) * n(cgroups) stacks is an overkill,
and there is nothing memcg-specific in these stacks except
that they are pre-charged.

> Can you also add the performance number for a similar simple
> benchmark done in ac496bf48d97 ("fork: Optimize task creation by
> caching two thread stacks per CPU if CONFIG_VMAP_STACK=y").

Sure, will do in v2.

> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thanks!

> 
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > ---
> >  kernel/fork.c | 44 ++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 38 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 69b6fea5a181..91872b2b37bd 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -224,9 +224,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> >                 return s->addr;
> >         }
> >
> > +       /*
> > +        * Allocated stacks are cached and later reused by new threads,
> > +        * so memcg accounting is performed manually on assigning/releasing
> > +        * stacks to tasks. Drop __GFP_ACCOUNT.
> > +        */
> >         stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
> >                                      VMALLOC_START, VMALLOC_END,
> > -                                    THREADINFO_GFP,
> > +                                    THREADINFO_GFP & ~__GFP_ACCOUNT,
> >                                      PAGE_KERNEL,
> >                                      0, node, __builtin_return_address(0));
> >
> > @@ -246,12 +251,41 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> >  #endif
> >  }
> >
> > +static void memcg_charge_kernel_stack(struct task_struct *tsk)
> > +{
> > +#ifdef CONFIG_VMAP_STACK
> > +       struct vm_struct *vm = task_stack_vm_area(tsk);
> > +
> > +       if (vm) {
> > +               int i;
> > +
> > +               for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> > +                       memcg_kmem_charge(vm->pages[i], __GFP_NOFAIL,
> > +                                         compound_order(vm->pages[i]));
> > +
> > +               /* All stack pages belong to the same memcg. */
> > +               mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> > +                                    THREAD_SIZE / 1024);
> > +       }
> > +#endif
> > +}
> > +
> >  static inline void free_thread_stack(struct task_struct *tsk)
> >  {
> >  #ifdef CONFIG_VMAP_STACK
> > -       if (task_stack_vm_area(tsk)) {
> > +       struct vm_struct *vm = task_stack_vm_area(tsk);
> > +
> > +       if (vm) {
> >                 int i;
> >
> > +               /* All stack pages belong to the same memcg. */
> > +               mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> > +                                    -(int)(THREAD_SIZE / 1024));
> > +
> > +               for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> > +                       memcg_kmem_uncharge(vm->pages[i],
> > +                                         compound_order(vm->pages[i]));
> > +
> >                 for (i = 0; i < NR_CACHED_STACKS; i++) {
> >                         if (this_cpu_cmpxchg(cached_stacks[i],
> >                                         NULL, tsk->stack_vm_area) != NULL)
> > @@ -352,10 +386,6 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
> >                                             NR_KERNEL_STACK_KB,
> >                                             PAGE_SIZE / 1024 * account);
> >                 }
> > -
> > -               /* All stack pages belong to the same memcg. */
> > -               mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> > -                                    account * (THREAD_SIZE / 1024));
> >         } else {
> >                 /*
> >                  * All stack pages are in the same zone and belong to the
> > @@ -809,6 +839,8 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
> >         if (!stack)
> >                 goto free_tsk;
> >
> > +       memcg_charge_kernel_stack(tsk);
> > +
> >         stack_vm_area = task_stack_vm_area(tsk);
> >
> >         err = arch_dup_task_struct(tsk, orig);
> > --
> > 2.14.4
> >
