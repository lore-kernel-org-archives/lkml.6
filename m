Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07472ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988BC205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="M3X35AOQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GITnj0N1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988BC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbeGQXax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:30:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33708 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729713AbeGQXaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:30:52 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HMra3e032349;
        Tue, 17 Jul 2018 15:55:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=tQqRvbIxv2CA6sKrLnEswrZBXALXb9SwXC/kafZILxg=;
 b=M3X35AOQGdSZihsrceKnUXFoLmq/wL4aSBQXhO+96KySJib1yv9bajGOMctU/hEejm04
 V6N3JPsnitE3uAlED95RchO0PpeyX2nVCVk7vEuv1Hbe+ZXe8QaYzWfMK2lne0KbGnP7
 izfadmSKeJLtp3U2KF7JKaVbY84u/+dHD24= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k9ntdrnm2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 17 Jul 2018 15:55:36 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.14) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 17 Jul 2018 15:55:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQqRvbIxv2CA6sKrLnEswrZBXALXb9SwXC/kafZILxg=;
 b=GITnj0N1ykJZe8K8t9Eyo7+VaF1Z0oyy/OxxNyNzmL3uJBZkvW2xaXPqzFn8wPZFvveV5cup1+QQFc+4nb6M8d6csNb1UT6Ab5Ezp/5nhPvUbQDWmC4deC92QCsRbmeyor4JhqLkFfwGNJ8stmh5OAGGNvii1LCbLbuQVKXA0Ic=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::6:c6f2) by
 BLUPR15MB0164.namprd15.prod.outlook.com (2a01:111:e400:5249::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20; Tue, 17 Jul
 2018 22:55:28 +0000
Date:   Tue, 17 Jul 2018 15:55:23 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 bpf 3/5] bpf: bpf_prog_array_free() should take a
 generic non-rcu pointer
Message-ID: <20180717225520.GA15643@castle.DHCP.thefacebook.com>
References: <20180713194114.2711-1-guro@fb.com>
 <20180713194114.2711-3-guro@fb.com>
 <41b5f919-3155-5bd4-2774-84efd58650e2@iogearbox.net>
 <20180716225715.GB3898@castle.DHCP.thefacebook.com>
 <1a40b0a8-7440-f2d2-d743-64901b5d1bfe@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1a40b0a8-7440-f2d2-d743-64901b5d1bfe@iogearbox.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::6:c6f2]
X-ClientProxiedBy: MWHPR12CA0067.namprd12.prod.outlook.com
 (2603:10b6:300:103::29) To BLUPR15MB0164.namprd15.prod.outlook.com
 (2a01:111:e400:5249::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1d36312-7717-48a3-7394-08d5ec3864e5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0164;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;3:DTvVJTpU6zSQOiBMC1Nf/PKGYeXJX5WX0/xVz05tw1S9iZCRy6T2YD+B7XT13trJSc2riMYsDnIsmk6ZwSXZNJMMPfKsGMx4+P6201p3BhyvjRrk0zRdnIKOuBlXswZoHsXz1B4D0GS+fY/ZIDhX4UaUVy1X7N+O4j7OE9kcRfQQNKWo3WEXM749tMVjyzfvDfugSsqmGJmFuMV/9MjioYG/H3lf3uumaUWzlxqLTqeAQiAjc4Tw4a6a1SUNzgqW;25:zltaOdNGGMYubszIPRBEn3ly8cdoxr2T97XIHUUGA3mXeZ6CyqGnhw53T969e11jsbBrF8T9pEXgr2PSBjgndWEtcI9rkljms42kEna2E0jGd8RIXOhPqFMQjMEouH4y2My1wZ3x65W2LiBOkSiMRpcT3OD1g4ONrcOT8G7eMYfo6yUMzwofu1/4aTAF6P5CPVM2HoQP7hrpS3BTZ8epGrx7iptbGOVxs5I55YfXvZRxikZgHTTdMpy5xLXHNxS+HZY9tTJoH1D/0FBd/rSjb936yRgZd8I4lglQRA6+V7bq16jKIeYA7EOFc3kAiBmPzGTPEPepdlELBjX7LIHcVEbdtp20ppMwXng7JZ5hW94=;31:Fj9ooRWCcA3rHPNCQ4qRtQ36RF/rDqaNQP98zZ/Ua+5yhqwJaOev4AJzTBHhPCe0RH6CNUnrJr/Ci336yezkK+6SxaDb176fJBXK313POpLSrqxutJiilQj0qIPsDsxXvYncMAwB4k6cStEi39pJE5jlR+JHqGVfZG0BhjTNwcDpsmcW9prN70ue8zaiGJWR5/+ldHaRkje7TDUbUYrmMeicqjnrTbjWExD08RMqE50=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0164:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;20:8o/rwCfV8eVJMCrYJdPMewtBJ2P1D0T/ErPvlkC26/z9Rj3OxwCzw5uJylxkWKGFvvbw03IDyG5jp3Q7Ls0qETEZEmOG5qPwrcCMjdV1N8ELte8I3u0Y+1HKd3+aFhN3ZcGEJwou9ujam9SxDuUQYhIVt9WKTSNBDUVYr45ZMzG5LRIYGpoj5oEqPIPTGNNCeplSuHcwCkG/ILwos3Qk2r5aS2/sNt6EiLBretmnP4DByM4Z3R/wmgUvgs1Nzb8UgZ5/sqXFxE1dSaj22eV3HOwGLae0aQXHDjD/uwqhXqFLI+OMeYNScQSq4dg6lrghDcZRfMTxp69pedbOxsAQn9DxoUiq/cl1flLDBYcKTmeW6LWR3Wq3/QfdsL3nsICClzXsDnv2IhLzMm1eVmZZXtnrNdX6pgxvN0UgzeMzW1IUhFugHRlJDO/nB0YfQUJEc421LV8QX1eJUEshVDfs49W0T5PAF2bHqLdTR+ydigA0Va+Yn1cnmfiUjP9YWAfO;4:/mhMnDgJY4wobq15dpHxARyjSZkbl8JD1lURxzzkzlNzf6t1Big+xR38OpZIzqpFybR7Jkf9szGBg4rkAlDG95LhY38CC1hyMfRufIaCbnXVq68/oReHPj3g6KZ/vgOg10gR/3z6DgEUaea3hHLsXkIbDzOwaJ+RsMtss/aLPnw/+8OjkcNz/SDx0E8MZl2cUqi/MK8eSGkLx3/FMzkF9uZ4fNujBEWjcipm8Q8QRCwTodboEYFi452MEzsH26whYxMs2NWKMjhCfXcwBkJnYFvWnQGC08riSXzM9jNC5H6BcVoNv1LnRM+ebPlPGHvwMWH4KUNohUmdaq3YlZXqJ+350hQ9NY72GVAQ2Ynervo=
X-Microsoft-Antispam-PRVS: <BLUPR15MB0164F316DB85D14CA53512E2BE5C0@BLUPR15MB0164.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BLUPR15MB0164;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0164;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(2906002)(186003)(478600001)(229853002)(58126008)(25786009)(6116002)(1076002)(16526019)(23726003)(106356001)(50466002)(16586007)(105586002)(4326008)(316002)(305945005)(47776003)(68736007)(7696005)(97736004)(6666003)(476003)(575784001)(86362001)(76176011)(386003)(8676002)(81166006)(93886005)(52116002)(6506007)(5660300001)(52396003)(446003)(486006)(55016002)(81156014)(8936002)(11346002)(33656002)(9686003)(53546011)(6246003)(14444005)(53936002)(7736002)(5024004)(46003)(6916009)(18370500001)(41533002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0164;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0164;23:MFG9Vyb5meHCOHrFi6p7g99bbriSwmIcuRbWdmceK?=
 =?us-ascii?Q?MP8ag9BHjJr4MapMBxZV9AL/GrqNhqgygm0ZP/EqTNyIqUaHbHqnKohNz5zF?=
 =?us-ascii?Q?zl3Oi1si+mPXRBiYy3oa+k0Wl7MtJlPnPwKk63EvgBbYwvLcZv3WraI8Tq0q?=
 =?us-ascii?Q?2K5PMzAyxUVAX92oq4tlbphECSoqOH54gn1dhvH/wtElD2PQIQFr0HWuQ6rQ?=
 =?us-ascii?Q?9ZU8Eo7dle5C0HT2+zH7zHzQiCzgAtWsuQe+0YLDdzlQ85y7tHPKLR6aSYEf?=
 =?us-ascii?Q?iyvqneEF73nVMP3VHJxep3Oqhqd8ApkoE+4H6cyTbFfcFufBq/4yWR6yhNTH?=
 =?us-ascii?Q?Tv13jr58wq16XSRrkoqKt5OwgukmZKbe7uCL1HPRPDwBeiiJsbo57SQpniIS?=
 =?us-ascii?Q?UX+rJaqQb/4gzlic8iT+jhcfSLE3tKfS98UW5E3Ilcck95VA/bJj2irHx/SQ?=
 =?us-ascii?Q?F5TemgCUvBpHnQlKExQZR33k1K6jjFbxfW14d2WkxMw/WXW9dvk+WAZc7grj?=
 =?us-ascii?Q?zgqrjKKvBhNyD09obo4MF8XlnW1z1MHyKkjK+1OFrGSMfpKM+F3mYG95KMkt?=
 =?us-ascii?Q?1J1clFC2fbfq3wBfJERqTyv3P8E1D+VsqZiHLEdY6Pt89wDrM7oRjfYWekS/?=
 =?us-ascii?Q?/awfuGeV4/AuWOVxvEDQXsNcm/fOAjFgNu76tIW0kiKIXx33Z7giYVvcwZ42?=
 =?us-ascii?Q?Jug1TwNWwFUGchDnMzTCUHbpFj5GjL7jqjie96k9EiWl8FU5Gd97gj4/iEcB?=
 =?us-ascii?Q?WRGzWH0sZnA8t/OwNm6FskO+XoQHqclil0Pjva9N3XfVL6milbx0VGXbfSon?=
 =?us-ascii?Q?3V8QaiH9fmjHInIo2oK8pHzBxkN4CeC8XYgBuARouIIS8RrSf0YZtsAJvigG?=
 =?us-ascii?Q?I5I0L40T6n7++5M1rjHAsVeRuaws5TDjKqYm92gJtdfTANRnoMpVsKRdP8kh?=
 =?us-ascii?Q?p5VQAAuwNxbpfyfZNvAOgVgYFsiorqASyQd7HcuhZCn1SBWKAxer6fUbNfht?=
 =?us-ascii?Q?sNZ7qcx92jsaFNDxvbSDtMz9Do3kAkAaGbt1VmjMWMNRoX2TKBPcaXPKSPdT?=
 =?us-ascii?Q?03CiiISBqrlcIhRlzjJbaYQO0/4wMRGTB9ziqBmvI3fAgEF0YkjQP0Rrphey?=
 =?us-ascii?Q?uxwjrtL7GdDZwQKAZy/IWwmSxzlKUxgRWBmwZHi2g90Kc/hYVAtNqZWXSSLu?=
 =?us-ascii?Q?aOTdLbfd6KLulEUum0W4c5IHAiWHERsSDqDHuO9O35DAEoEULzQdILzeJKyF?=
 =?us-ascii?Q?3k1VAPGfcuVh9SR25nOHpsBaaWwzZpe9h6Z3OR0hnCF5qRhUq6AgL3s/9k3x?=
 =?us-ascii?Q?FBlty6W4FamSz57ifVVwyLjw5wGBdr6umG1d+iOd8/QQRNJ443t8EPzEK6+K?=
 =?us-ascii?Q?Kcg5Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: suYspTiGwVUsMnFFpFUevu1ibq5JN/o+iYa1IYwEJq4JjQeJ1kyZ2Ypdm5wPPMZsJJQU2moHvWxFMp10kCNuix90X3ZAqd3SX5Dt4EeJ6xPVMVlOOZHy3vI7Y2kML2ky4d2F8ZbPjl5vBRKxcdGTinwCKSVRcv/uQNQ3pLgMbgtrOftVTednNvwwTJkHL290ekkmDoUrb0UjhJLmYNhRLMjQrHE3lNlG/nWCoWjKDRvnubSzAnVJ4NIsn3jNXAR/EoUzg45jkEglHPl3zE4AAVGArwMEZ9nbzoyS84X3R2B23Z//+dOumOum9w0VV5Kn68iMfeStNWh6xITM6IBRrRKm+3xIyvHnm0IX2poSWY8=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;6:Ad0qUvo19jUy7SQLvvx3xTSQfKtqQe6v2uJ2cQYyZMPCEy4VIyH3RuVMx6Imw81YgHgf32O47VSQQ+ipkbk/pYd1km20CGXSidaIxLO/xd8BysteRwTQtLQefu6dPitSWEtr5pybJqakO2f383r65g+xQUHD3ZE88MZvqW4gvnczlmA3HJEF3RqJCdRqsSi4CBmx5gqGhZNP+Ib0FXZWqy7CwIEnzB3jn1qtTb5viX+62pROoeMnNODQytCg3Tq01M58JYH/vTpjz+nH26v2NxyMiuIcgeravMqEEfW8176P4DqIpsD8tljmSlHO06HVp3e79Cp8roAht319wY1Tc6fUoc0TJfF55WuYLDhb8JjmW6hUwNTy4qQXsXo8MlMD57UEYXlWqPXGM5Qc/AvptCwn0L45MdbcWL/Y1frzWlvZQ8hIPfMYOLcQlmTGxSCy3mJf9Z+HrUWa3mRH2rndkA==;5:fYdApCtvoV244ScTKTGBCXJYIvQYYku9eIhGOwaUr12tvqPyp9HssxDQLq4zYhj/C0wOVHvyYusACWMJ5DG+9sDikf1pJz3Y+fwXT7w30UsOYmPSRSaq1fjO5i4xlf5xgdzMQf6y/46ea/1roUcHocdE2xbhskqOE6VzoqeoiFA=;24:wQfcWRzBMVvm69m1ZsOK6rCFX5ZRWQKVzZ4KkKnSA/vrZglDDo0I7NXD/cQfexkD1scmVOvmWNkIVJBG1PrzqEat7enSKIY54q1xxqwH73Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;7:oIENsrffoYPw9jFzlD3pzSuNAtlnYQ98PDFL7g1TaPmqYaRXtIMuvEogmYm0m/32oXVyfQaEjiLSjdfzcx5xCvZw5ywV6ofG+UbAyDx5USlyPFt+NOUKpdll5I+9TUnnzHI3vch8KMa9abYrJ5jxT70nyKnI6CaDrEDyQqmXrvqUJMQk8VECgS08sF84reqCfo1kYaYCxt9jq102Z07ilb+EojLd8IIV+as8r61wFESDKx151WgEjryPRyltHVeR;20:/oPvYSJiYey2T/SZYc+L1VRbs33gPK2jOWbpPAG+lTevQ4G3eyMLDvCe0GDoDBAaci69ZhdHSfIDQ89JESwAV0AoLfbIp4weGpYTnmDrpHVyBu4AvkB2z1fWGfAAaHa2hwjEh99mLKDNHYi3KEv1uKBAQKbtNOdy59MUFapge3A=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 22:55:28.9718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d36312-7717-48a3-7394-08d5ec3864e5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0164
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:38:50AM +0200, Daniel Borkmann wrote:
> On 07/17/2018 12:57 AM, Roman Gushchin wrote:
> > On Tue, Jul 17, 2018 at 12:30:18AM +0200, Daniel Borkmann wrote:
> >> On 07/13/2018 09:41 PM, Roman Gushchin wrote:
> >>> bpf_prog_array_free() should take a generic non-rcu pointer
> >>> as an argument, as freeing the objects assumes that we're
> >>> holding an exclusive rights on it.
> >>>
> >>> rcu_access_pointer() can be used to convert a __rcu pointer to
> >>> a generic pointer before passing it to bpf_prog_array_free(),
> >>> if necessary.
> >>>
> >>> This patch eliminates the following sparse warning:
> >>> kernel/bpf/core.c:1556:9: warning: incorrect type in argument 1 (different address spaces)
> >>> kernel/bpf/core.c:1556:9:    expected struct callback_head *head
> >>> kernel/bpf/core.c:1556:9:    got struct callback_head [noderef] <asn:4>*<noident>
> >>>
> >>> Fixes: 324bda9e6c5a ("bpf: multi program support for cgroup+bpf")
> >>> Signed-off-by: Roman Gushchin <guro@fb.com>
> >>> Cc: Alexei Starovoitov <ast@kernel.org>
> >>> Cc: Daniel Borkmann <daniel@iogearbox.net>
> >>> ---
> >>>  drivers/media/rc/bpf-lirc.c |  6 +++---
> >>>  include/linux/bpf.h         |  2 +-
> >>>  kernel/bpf/cgroup.c         | 11 ++++++-----
> >>>  kernel/bpf/core.c           |  5 ++---
> >>>  kernel/trace/bpf_trace.c    |  8 ++++----
> >>>  5 files changed, 16 insertions(+), 16 deletions(-)
> >>>
> >>> diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
> >>> index fcfab6635f9c..509b262aa0dc 100644
> >>> --- a/drivers/media/rc/bpf-lirc.c
> >>> +++ b/drivers/media/rc/bpf-lirc.c
> >>> @@ -135,7 +135,7 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
> >>>  		goto unlock;
> >>>  
> >>>  	rcu_assign_pointer(raw->progs, new_array);
> >>> -	bpf_prog_array_free(old_array);
> >>> +	bpf_prog_array_free(rcu_access_pointer(old_array));
> >>
> >> Taking this one as an example, why can't we already do the rcu_dereference() on the
> >> 'old_array = raw->progs' where we fetch the old_array initially? Then we also wouldn't
> >> need the rcu_access_pointer() on bpf_prog_array_free() and yet another rcu_dereference()
> >> inside the bpf_prog_array_copy() from your later patch?
> > 
> > We can, but then we have to change bpf_prog_array_copy() args annotation,
> > and also all places, where it's called.
> > IMO, basically all local variables and function args marked as __rcu
> > should be not marked as RCU, but fixing them all is beyond this patchset.
> 
> Right, agree, the __rcu markings seem somewhat arbitrary. :-( I think we need to
> investigate this a bit deeper and do a proper audit on the whole bpf prog array's
> RCU handling (probably won't get to it in next two weeks but put onto backlog just
> in case it's still unresolved till then). That said, given this has been there for
> quite a while and it's rc5 now, I think we could start out on bpf-next with the
> obvious candidates which should be okay even if it ends up bigger.

Totally agree.

> First two from this series we could already take in if you prefer.

That would be nice!

Maybe it will be enough to land the cgroup local storage patchset,
what is my primary goal now. After that I'll try to look at __rcu
annotations too.

Thanks!
