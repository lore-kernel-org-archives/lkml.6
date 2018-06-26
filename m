Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F04C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B03126C1F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gUBGLzwS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eviOkKrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B03126C1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbeFZQtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:49:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53414 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752489AbeFZQs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:48:58 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QGj5l8001600;
        Tue, 26 Jun 2018 09:48:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=+YLNWF5K6W19FwaBUwiWxUsjK8w37zM+t9N/QxQ46RM=;
 b=gUBGLzwSVzph3NEQVqmhU9GwagPc2GnCfTPLKkw9OJ8KJVyz1wnr8eTYI3cfnB8/OMNK
 mWoAZE0y0h9yhPF1IR3kMg1OcdeGzxY5Pr68wa7fLc61AJdu5dqAMztgXykNrDuZ4kz5
 4asVKUqEern58clOLTr3/DsgRb9EZsE7Y30= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jus8m00h3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Jun 2018 09:48:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 26 Jun 2018 12:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YLNWF5K6W19FwaBUwiWxUsjK8w37zM+t9N/QxQ46RM=;
 b=eviOkKrcCwrrCQbDVoVFKzCRitEekc8dhRBYANyEsoE+N7vhNCSD31XrV9voYiUEfAW2HL8mbRNDIe3/Sng+n+OPx5qcG0OoZAttl/CFaKHXrnDGaAV33UgHZyeU1r4R8CgQwywd7UEJj5Foh+KTGKa92ET2gRer9HKrABXxAGw=
Received: from w1t1fb (2620:10d:c092:200::1:a234) by
 DM6PR15MB2507.namprd15.prod.outlook.com (2603:10b6:5:8e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.23; Tue, 26 Jun 2018 16:48:37 +0000
Date:   Tue, 26 Jun 2018 17:48:22 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
CC:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180626164820.GA12981@w1t1fb>
References: <20180621160719.2cfb4b58@cakuba.netronome.com>
 <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
 <20180621172523.6cd00ed1@cakuba.netronome.com>
 <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
 <20180622114032.162b2a76@cakuba.netronome.com>
 <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
 <20180622142743.2b890d0f@cakuba.netronome.com>
 <20180622225408.jor7lpvsksnwiiec@kafai-mbp.dhcp.thefacebook.com>
 <20180622163200.20564ec4@cakuba.netronome.com>
 <20180623002639.h4qxy7aakypi6t7b@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180623002639.h4qxy7aakypi6t7b@kafai-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c092:200::1:a234]
X-ClientProxiedBy: AM5PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:203:69::11) To DM6PR15MB2507.namprd15.prod.outlook.com
 (2603:10b6:5:8e::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd7007c3-da73-41ca-1502-08d5db84aa9e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR15MB2507;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;3:A5ZUK4fcr8q68BXkGq8GPfT/GPcqdnnMD7hjvdR+GpbHpqyWNOUUeqt5DLc9tAPnh2PHBaBeezgNew67QnVOPx8exn+ONvMAvfcoyYWS/gHWzmw00pHjDkHnsUWD6BO75PI6+hAt2w2M1N1lX+7jOe4FoQruUQATw9BWbbfWAaI3CuFD3nKjzEIeGaL+GqOoXOo/89Og8yKZPtAjSVyqMD8RqNX47fIKcrVooP0xqNZJSmi8qCSqxOlDl9FQElCQ;25:2et6on/kWcqnVZNZ5oaRoD6DTCOA8zIIgWDbxx3rYKNLPwOOOFqrXNVDIp6pwjDTmcG0TF0YLm+xjz2u+SEVgJd5HQImme8sxJC/y0ifF8b4NsvmvmN0xt89vjSUnScUrTh59ucY4x8eNpjqjKzemsuCxK3GtKDqT7zvyLVhgBQ3ZueCzRzULu7lXCg4NkOYshgzK2FUotaisb3ulIA0vuMxkjJ5gcYendKDoCHXSMnav/mO+t8fgUQsT27nYqR2AcmgeUQBzlwhjZFgGOrt1Uh8pWSMRfjvZxqS5bO10yuJjQLLyi+sFdTvU4WOvJc5Ud+6gFKnxw7WdimNlCqK5g==;31:7ZdnyP/IRqPEhI1xUODY+t0i5alD3fyK/evd0BPm/tTbrAOIa4GdzIPghQzkICQI3P4qT4lb8pAyM+HSMah6gG6taybIKPmFbn3721eF5+mg6PHL2TDIjufLyifadTcHChW4r9iVPdqRB5WRZXDm72F4918o92ocGx5GXusbi2YCf8UWRinWI8oQq5h3ZCvfAIjUi8kG3jIexPNiVjs/5PMjMAAhDf3V3YvFlQDOxZI=
X-MS-TrafficTypeDiagnostic: DM6PR15MB2507:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;20:ce8RhAtjGmNbdko8Yspj3dKDp/vm4Oen+l/ANTthrwy8wpDZV0IVDwzz32JARe1J88WkfYWdropva2n7NB0FQKC6wYZhVKyhjKOns5Yb7cvOostvGz+4Bbfxl4IwRO/jecAC9uE+3ze8GGVExvQ6rbVQXdsqudEz1dftmg984pexAb2YjwsZ+gCEpB42igD9xpqSyzJTCbRIXNAxMg3Msu6qmnQ2q6vsiAt3B9YdLfgBxA0ISTLiA8bFj8ueUWUQMbx5fPgYc3TTLwAI1MX/ERPd37AcK/w1A9y5tYG8NLEdg3EJ1Usy1CURJ7bXkcfTu/0lF8jvtkQvFjmifMKntISAh3uEKrncvzY4S5bokd5tyhlz9BbbJLZwdCfb/6NC573m/C8UZ5sOFWIQ5IK45CxS67PF60c0GOJMoErwA8/CkyivWmAEgbnQl0FrcHauoiwRjzzPCcGX7Rn8FbYo2w4wGCzX8Brm0M4fksAnShZYCc6Et91pLrE8ziup3cBJ;4:JdXBoLpxrajstPhlsWhB55jaY7jhmTjRUldGt4VnGPI1l2fcVul6Y75LmWWklnNQgX+TxEbBulzVKv1vvBq5+opVVOviglbboXiabfBfSHj4+Jp6nFoJWFbeOpiKfVVGZQgyHhohamK5i0Uyt7QRnwWi9LdtorNw91I7EzpK4bXpcueJwX4nadaTaSA8Pv15Na4JBymO6QuD2+cFzUvmhtGrnrlXsw/CeKcFQJL6179x5rnIEw5dH95zUJQzkgLrtumsy3TC2oyatOjRm0XwMmGxY3dKA9o0m/0ZHiht61XW6jLrjvomGPi4g2iJLSwC
X-Microsoft-Antispam-PRVS: <DM6PR15MB25071FCABE670F034250A94EC6490@DM6PR15MB2507.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR15MB2507;BCL:0;PCL:0;RULEID:;SRVR:DM6PR15MB2507;
X-Forefront-PRVS: 071518EF63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(51914003)(39060400002)(76176011)(54906003)(53936002)(93886005)(52116002)(316002)(68736007)(9686003)(46003)(16586007)(58126008)(33716001)(25786009)(6246003)(81156014)(4326008)(81166006)(86362001)(6636002)(5660300001)(6666003)(55016002)(33656002)(478600001)(50466002)(47776003)(8936002)(105586002)(33896004)(6862004)(106356001)(8676002)(2906002)(16526019)(446003)(6496006)(52396003)(11346002)(476003)(486006)(305945005)(23726003)(1076002)(386003)(97736004)(6116002)(229853002)(14444005)(7736002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2507;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR15MB2507;23:15aE4b2JV+fbfi4GFIsDD+grAn98GeIZVrHNfrMeV?=
 =?us-ascii?Q?U0emHbbw0iln45km/WG85N78QfbiOe+VHO4AtxUAId0rvplhD4bTeuBxLOhn?=
 =?us-ascii?Q?TtjVW7UQ0ZkxToKb/N9jJOHS3H1D3Nm67q01x4SeSlPDAaeSCN+Srr8iv38B?=
 =?us-ascii?Q?Q24IQ9/xKJQhGyEaHBgw9K8DdFSV6kU77kjXK6+ctKhNzlX0RfGOgB5wScRS?=
 =?us-ascii?Q?d0QscZmz/HcGa1fPIJLylPVKKfA4qubH3Q+w5IhPitD28GVEP/Aexs56FnLO?=
 =?us-ascii?Q?geK6qwmlPdFeyL+fRbpCZrbURMDKTguyUXC07GC/ni6orsDXYT9uu4PQLg3k?=
 =?us-ascii?Q?pnR4BGR2r8ZVjPB5Et7qMsXigPLWgsL2nkL9BvWnUQ0o83fzHDA2ufaH8p5t?=
 =?us-ascii?Q?PYy1Dvug9XrCyV03ZuhrK9G/6XOQW+IZL4MqvitPWWzr+iZWWaV+h2+ax3uS?=
 =?us-ascii?Q?PHSXdMR9wIcebbSErIyNRQNffCZBXiAKHIk5XSsiQEf6CvnZpZUA01fFI1xz?=
 =?us-ascii?Q?lrpJBlh1kIlmwZAVh7xGhLJjGN3b3fc7/PKapEXYVXMgC4Vrq3vKI+pb9MrN?=
 =?us-ascii?Q?Rt8lT0IWAsiVuQzHpaGahOSSXGyx1O1Du+U54a5LJCb6MsPs6wdXQZD5H0gd?=
 =?us-ascii?Q?3xHkKmLUnIVv8MaXs7Z0q4ebwWCuoqz6IvPguAReQ1mskO/6l0/vXWJHkdqM?=
 =?us-ascii?Q?UIepF55AbjwiETZt1imzeBqVyaeYcQBxc03UfTVwAiH/C/ZLtzdKYB3NHXZD?=
 =?us-ascii?Q?Ak/j7jqcWwyh5ZcmHtFwi3omHOfky+VGz9ajmUCZMSGx5EvC1XAiIYtiVbeS?=
 =?us-ascii?Q?9IxH0lXVVEnQuRjQTmsGjirHDdFvB/RL3YAVZsqunOzEM2SeVCRfEq+TsrJX?=
 =?us-ascii?Q?otHsb0vAKMAIaMBtMsVQG3I3Q/HHrscAlvUG4EpdX3YBZ+fQNgUqj7ZFghqE?=
 =?us-ascii?Q?uKNzLzs/+JfK2CcpJP/HQxN3QqqAwzrA+AWcI4CYVWQMruo/ycbEMNf1Jg8+?=
 =?us-ascii?Q?+uDnwH0U6I1u0DhYpfjw3bfSgf03NaWshKu5cabFCw+BKnBfcg2hzO80LROH?=
 =?us-ascii?Q?EzbfKI6NYwt8dlMbcTnMpIXLlZe1dY6O7SHipjAcXaVs5IRJC8VO+9sjBH95?=
 =?us-ascii?Q?bd8rF24VJ7NXSrA3OeM6zV8whUJisOt9ZViy2NSIEj+uemyoU28avMHWR085?=
 =?us-ascii?Q?qPKtpOUyQqMMnYx60FqZkXFjV4ssg1sm8bxn3HHCV0CmKCmqBjA09b0t3zFu?=
 =?us-ascii?Q?EsI3QjWDGLKmZyUwBrOk+jpIZRDpwffo1O7g0DhxGFDs11+uFejwa9BXBYsn?=
 =?us-ascii?Q?S4QTC8bU2pQg7mm5x5opp1pwz7IBc670K9200V+mEpEo10EyOVf2ceDFIDz2?=
 =?us-ascii?Q?UVrcA=3D=3D?=
X-Microsoft-Antispam-Message-Info: p2XiFV9QqoJBVhb+bCjes9nB4ipTTuggBL5/UlkNHhLbKc4XshfJ/CKAiS5HffGrOBcW5YnKUmpxKd0+4x5Lq2mBAfWKkx3TzSCVhcpZhvCWFDNGhRsuirg4vbgAewT46qIHlC0wuRBKik8/Gsg4xzlJGaMPfJJaTzSKGKkWIIiulTUroB18c05qdWp2dbqqQNwCALnfj/gHg6Oa2SRdtNXprITh7bO3CgM314SCX4wx7KAKMOBNm75mYjFmkfSjAqJPIn3JjSn68YDdWNTbfTTohoyRFlDTQw9M3zq0noy9rVFC2TWWGfeK7aVYpu9cyc2WMQ+DkpPtrvqD0EiCW9HhLJS7pV5ngyNSUGfqQkE=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;6:wrHqF3XVXgrdSndX+LFxj6Q0gCif4ZbTewg1ZdxAkmuiAxyzzVw5MrP7jO6iwNHUu6lmL2EzIB8Ur1BD0LEI9tfKjhMEPKGqrcEBw6Q0frcDgIGwLBd8w39xw1mWVEPKP2O9B598n3A1GHDgblNO3hsIDPOPJglafm+E5ZOHwGBM9sodYZ56YRjRNMg5Mho1lHciyhjb+LDD6Eh4t4So/QXwsNJCjaYfPfFFF3l5jO9plTat9sQpn02cpAtAy7d2Z34ayj+zA6o5lf//g/xaWXVNeUbraMtViBehxbqTzzxvGRtfuMiJDeFbsPnMRNi1JtxJ7thrfGt8A5T7lctRXaThz1IvoxJRb8wf1Ay/IcKscX6voNTNUKp/o9h8ca6v5pYT6MV3QdorlNp7AGh5skBexSJ8+kYgNjuH/Yh5SEaefW09GlBFLSi7KY7YlVR3dm1EoIjbaoqHIz/tQHwMSA==;5:Mz6Aj9MApb6mEA+rT4/ApNdP5YZDXugNRUQO1jhhczaROGTVjNsyeEcDzSw5rIWRXM5Ssw0xkDxT1RVIu3Jcu5x7z257WI/J41yNRL/aXt79y2Lg+IUlKWE71Z9oFpJExj7Iq+F0vSDbSCtqcp6HemKP0bllc0cUgbq2UkbyuCA=;24:h3RUBQXbRP7QqYUwqqrMJqPKv2eB51rlravLFvKOeYkMDQBPYvGoDoS8w28fz1NOuctnVl3hXlof1Za+bXBMzPmsX20+dYm79sDqieeeNr8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;7:HzTIBxjJ++adpUXXWbcWpuaWKuaPY9fv+LLOLwoGt8WVA7t2oPKtQElE6bqtrR4IkFw8Eje1R7uAXmjt7SpyyOR2RcfT/ikpn8q1Oa2VMcYuuUBvAOeGnVmWeWVT6b8cBS4mdS10sz5BtBaF4ixLpI/5ZOqFPPjpRsdKENugI1aoxUgU4+nxV1bi23eSIh1ukKK0VMfQ/5y9vzTPd0qLPQiiqOtdLG87xjwN4ua8vVug/9j8fVbVTmDU2uQ1FNwf;20:3ExUIND10A1UHjtR31OgwqDLiwJ7MJmGqnR8aZBgLhNvhJY6okbnna2Z0kCRn704hCy6AUhvrkrIzLssVw3azXmX8yqLirJrAElHFT9zhs8irLHoZmq8jxnc/qL5QA6B+uwinY5usHqh+HAmXcdFMCL0AboLdxNDXYqGVjMXVoI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2018 16:48:37.1976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7007c3-da73-41ca-1502-08d5db84aa9e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2507
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 05:26:39PM -0700, Martin KaFai Lau wrote:
> On Fri, Jun 22, 2018 at 04:32:00PM -0700, Jakub Kicinski wrote:
> > On Fri, 22 Jun 2018 15:54:08 -0700, Martin KaFai Lau wrote:
> > > > > > > > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > > > > > > > >         ],
> > > > > > > > > > > > 	"value_struct":{
> > > > > > > > > > > > 		"src_ip":2,      
> > > > > > > If for the same map the user changes the "src_ip" to an array of int[4]
> > > > > > > later (e.g. to support ipv6), it will become "src_ip": [1, 2, 3, 4].
> > > > > > > Is it breaking backward compat?
> > > > > > > i.e.
> > > > > > > struct five_tuples {
> > > > > > > -	int src_ip;
> > > > > > > +	int src_ip[4];
> > > > > > > /* ... */
> > > > > > > };    
> > > > > > 
> > > > > > Well, it is breaking backward compat, but it's the program doing it,
> > > > > > not bpftool :)  BTF changes so does the output.    
> > > > > As we see, the key/value's btf-output is inherently not backward compat.
> > > > > Hence, "-j" and "-p" will stay as is.  The whole existing json will
> > > > > be backward compat instead of only partly backward compat.  
> > > > 
> > > > No.  There is a difference between user of a facility changing their
> > > > input and kernel/libraries providing different output in response to
> > > > that, and the libraries suddenly changing the output on their own.
> > > > 
> > > > Your example is like saying if user started using IPv6 addresses
> > > > instead of IPv4 the netlink attributes in dumps will be different so
> > > > kernel didn't keep backwards compat.  While what you're doing is more
> > > > equivalent to dropping support for old ioctl interfaces because there
> > > > is a better mechanism now.  
> > > Sorry, I don't follow this.  I don't see netlink suffer json issue like
> > > the one on "key" and "value".
> > > 
> > > All I can grasp is, the json should normally be backward compat but now
> > > we are saying anything added by btf-output is an exception because
> > > the script parsing it will treat it differently than "key" and "value"
> > 
> > Backward compatibility means that if I run *the same* program against
> > different kernels/libraries it continues to work.  If someone decides
> > to upgrade their program to work with IPv6 (which was your example)
> > obviously there is no way system as a whole will look 1:1 the same.
> > 
> > > > BTF in JSON is very useful, and will help people who writes simple
> > > > orchestration/scripts based on bpftool *a* *lot*.  I really appreciate  
> > > Can you share what the script will do?  I want to understand why
> > > it cannot directly use the BTF format and the map data.
> > 
> > Think about a python script which wants to read a counter in a map.
> > Right now it would have to get the BTF, find out which bytes are the
> > counter, then convert the bytes into a larger int.  With JSON BTF if
> > just does entry["formatted"]["value"]["counter"].
> > 
> > Real life example from my test code (conversion of 3 element counter
> > array):
> > 
> > def str2int(strtab):
> >     inttab = []
> >     for i in strtab:
> >         inttab.append(int(i, 16))
> >     ba = bytearray(inttab)
> >     if len(strtab) == 4:
> >         fmt = "I"
> >     elif len(strtab) == 8:
> >         fmt = "Q"
> >     else:
> >         raise Exception("String array of len %d can't be unpacked to an int" %
> >                         (len(strtab)))
> >     return struct.unpack(fmt, ba)[0]
> > 
> > def convert(elems, idx):
> >     val = []
> >     for i in range(3):
> >         part = elems[idx]["value"][i * length:(i + 1) * length]
> >         val.append(str2int(part))
> >     return val
> > 
> > With BTF it would be:
> > 
> > 	elems[idx]["formatted"]["value"]
> > 
> > Which is fairly awesome.
> Thanks for the example.  Agree that with BTF, things are easier in general.
> 
> btw, what more awesome is,
> #> bpftool map find id 100 key 1
> {
> 	"counter_x": 1,
> 	"counter_y": 10
> }
> 
> > 
> > > > this addition to bpftool and will start using it myself as soon as it
> > > > lands.  I'm not sure why the reluctance to slightly change the output
> > > > format?  
> > > The initial change argument is because the json has to be backward compat.
> > > 
> > > Then we show that btf-output is inherently not backward compat, so
> > > printing it in json does not make sense at all.
> > > 
> > > However, now it is saying part of it does not have to be backward compat.
> > 
> > Compatibility of "formatted" member is defined as -> fields broken out
> > according to BTF.  So it is backward compatible.  The definition of
> > "value" member is -> an array of unfortunately formatted array of
> > ugly hex strings :(
> > 
> > > I am fine putting it under "formatted" for "-j" or "-p" if that is the
> > > case, other than the double output is still confusing.  Lets wait for
> > > Okash's input.
> > >
> > > At the same time, the same output will be used as the default plaintext
> > > output when BTF is available.  Then the plaintext BTF output
> > > will not be limited by the json restrictions when we want
> > > to improve human readability later.  Apparently, the
> > > improvements on plaintext will not be always applicable
> > > to json output.
> > 

hi,

so i guess following is what we want:

1. a "formatted" object nested inside -p and -j switches for bpf map
  dump. this will be JSON and backward compatible
2. an output for humans - which is like the current output. this will
not be JSON. this won't have to be backward compatible. this output will
be shown when neither of -j and -p are supplied and btf info is
available.

i can update the patches to v2 which covers 2 above + all other comments
on the patchset. later we can follow up with a patch for 1.

thanks for valuable feedback :)

okash
