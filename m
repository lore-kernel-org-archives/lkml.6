Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3462AC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF70220875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VdB/KObg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BAfYLGk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF70220875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeFTWtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:49:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751767AbeFTWtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:49:45 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KMeK77012437;
        Wed, 20 Jun 2018 15:49:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=uDC9IEJMk3WpX0zNQ0syQCO0LEykD966ENK6/amNOPQ=;
 b=VdB/KObgmzYuoEhUXeszXeAKrt6zIwpwrzpMVTx/hK10reKYkujmPqHkWuGh2k37G8Mb
 8irfp9j09f3jBCBJoH6TEvcVY4rd/ciLzDvHgug2IbVfrCndBiqvedtbkhy1iXhvLlgb
 JoprJkqTHZlmgAt5a67kO27DgY5wV0v5e4E= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jqvy2rhby-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 20 Jun 2018 15:49:19 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.16) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 20 Jun 2018 15:49:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDC9IEJMk3WpX0zNQ0syQCO0LEykD966ENK6/amNOPQ=;
 b=BAfYLGk+2Lh6fEAqugp9RnR0ZswLZYi3x80hv9IxC7QerhzKfE/tUnrZiAgVnpPHdwnlNw/VUI3yr5GOqfLH9OjKtqY/FARM9uChyVq1DjV7RdIdJUgNGfrBaRzpEpA+7XxuXSVkksd5XgcmN5/pDBoOYoBO85TdZI70CgdHKlM=
Received: from w1t1fb (2620:10d:c090:180::1:a887) by
 BN7PR15MB2499.namprd15.prod.outlook.com (2603:10b6:406:87::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.19; Wed, 20 Jun 2018 22:49:09 +0000
Date:   Wed, 20 Jun 2018 23:48:50 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Song Liu <songliubraving@fb.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/3] bpf: btf: export btf types and name by
 offset from lib
Message-ID: <20180620224849.GA18488@w1t1fb>
References: <20180620203051.223156973@fb.com>
 <20180620203702.996737905@fb.com>
 <AD663533-9EF3-47EE-A2BA-87E1938776BA@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <AD663533-9EF3-47EE-A2BA-87E1938776BA@fb.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c090:180::1:a887]
X-ClientProxiedBy: MWHPR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:301:5f::49) To BN7PR15MB2499.namprd15.prod.outlook.com
 (2603:10b6:406:87::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73fcc09e-d544-477c-c678-08d5d7000b9e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR15MB2499;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2499;3:3MxUEm1mPguZISauSuT+dCiW2gTtSSyZdy41eyLNvpZFy7lMq1JlGqV+c3b1U8LqRyEZixLSE9gcdQhAosqxqbuDROgg7lHJG/2m7Xd0PCIwJLVHWAaKo3pORut7vHBtLVYc/72RpXsapr87IfapvsSE+ThiRe9NaGWaKtkNXJg6aTK7r/PRWXOjoO1jrtUs5ouaJyiFrpXeMrAGBGtFSWdUsia7yZ4tqnMSjTTvcWNm0YHYCSzupYz4q5aucQ5w;25:jKJG9oop0d4NaK5mwzR3Rcvr0ihAMufTp7kxeO2qvQmi2fQ330p+TGNcVm0EaNjWHLeCIwQT/iYE7BuE2RgocnVmHUVLvDIUiMAJCqGQIcJv3MK/5s2/H5LvyLATWmSzLw02iWvKlW9S8HlK4YpsGa4w7v+WUoA+EEZLWWXrmQFy6LsdAbUNb/hXMYBfsCSKd2LVCOwZAG2V9lKbp9jhuIzXtmNGjZNlMFQVE34p29UTVWEpuul9p9DdzZJxPPizSwJrZqI3bU73Si9Dt2DIi5WuHGRTWqALBLcl94Bo46/0DhOHl4lgm3PdEIB+tZj0wr7o45+/H9m1NTewL38nSw==;31:PETM5/6GVSSuzUpHJDaI5uY2UwsfQa8bQ0ECKtgDU14c9S1jgfW2/wOr1m88Uj2K5G01tkDqxeXUW5r17fc9ZQ/YunawbODlbK+tq8WU4i2fmZOAkT25l9fouiRDV0xTsDnMB8L/Wz9Bh+VZ1GnuJuM9VvPLzdlUUx8Psdj5GKiRt3AbmmcStmvBNhhekVFVYLf0ls+fUYpRaOK10dEJuGxC+5h/66jyj1Ff8wnrgbA=
X-MS-TrafficTypeDiagnostic: BN7PR15MB2499:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2499;20:pwluCsGLfkZCRdtnyBF4RLO1+oNkF0yUQAI9IlN/M/OfeL+guSJ5jc1qcerEJiJKedVHvUJnWcuPoPPPLD56nA4BDEHbBapj5c4kc1RZHesgfldXsLASfTH0W3T3W8Kj2vaits8k9Wj7bNH97BOl0OHRwb3t08riiwwlVH9dW+foYtRTZXXzf1BEU79DDIGRU1zfIkphJYu3s0b8DBwAs0bNGBErYwNZUbGPY28QjpgVMO98fMqEdpRCqKjgtd/f6gf8xDWgIJHG199XNptxBi+kCdphxDRay+EO6G6hmuM8zNmj3KW4zMNxKBHH4/0Rk+j1TPII30mMWUM7dKB36EIPcDUKoAr4wH/yRj1m7F1BNxT6uR7Fez5O9cnYQa3xbB8xuksrO8bVootzNW3Bw/r/fwvod3e4ydUop1thLfqUlZo1apg8VKnU/LpkHA43dLSpp5Hd3rI/GG6xGOBgjb/81DhcVqBsObyGSzRBkJV22/B3gkJN84VvF36UMta1;4:U4OqkACpyCAMZKUaZi2xK6VMRXZYbz4CcGDuFrcSw6XWlJQzGX/rVu2a0nru8QzQmDwKPCs4xinb6xlmZDnifXT1kMz9N7NN7/mRVEFWw0t0Dlbzn1WLreQ3+oG6RxffN1TTIXw2jCIKsMa0HOozYoTQlLYCDOIgklrBUXpka8Mk0SFTlbCIavIzNa3Au7He1CPTyiUCUbTrWXFBIFuZgyRCaxbwUz6s9WsM6Msi/DE3YObpJiQq9dy6eT/bIsiHe4rKCQKOo8OFzdKGE2ccUlBWI2uDL57oOt3rjoOm9uCrUSLuoRnHMdN7Xw2z3Y7za1HbSLfeJZdqV8jOj1MXDVKCN2plKdalYrzIf+Sjgos=
X-Microsoft-Antispam-PRVS: <BN7PR15MB2499B50A99F1A145E12900E2C6770@BN7PR15MB2499.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN7PR15MB2499;BCL:0;PCL:0;RULEID:;SRVR:BN7PR15MB2499;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(39860400002)(376002)(396003)(189003)(199004)(57704003)(478600001)(7736002)(4326008)(2906002)(53936002)(47776003)(229853002)(305945005)(6246003)(1076002)(23726003)(8676002)(68736007)(46003)(6116002)(39060400002)(25786009)(86362001)(6862004)(50466002)(486006)(54906003)(53546011)(476003)(446003)(58126008)(9686003)(33716001)(81156014)(55016002)(81166006)(16586007)(316002)(97736004)(8936002)(386003)(16526019)(105586002)(6636002)(5660300001)(33896004)(52396003)(52116002)(106356001)(6496006)(11346002)(6666003)(33656002)(76176011)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR15MB2499;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR15MB2499;23:4xPeTM+VdGkmZAw58tFsHBFUZJGXH2n2qc5sUYKwq?=
 =?us-ascii?Q?R1WVZSTyJ5thcvLAp6jitxDA6M5/QoyE2Ez62bI4sQr/NKUkv3kLv8MfwFf+?=
 =?us-ascii?Q?4f8kZe6tmaTAzeoQSKFsQjO/WaesDPPQPl2vHhWT3t8t3SDB36+G8Ra+ojNk?=
 =?us-ascii?Q?NZF3kNFME60TIj/5uo+btAU9tqunKXsaCayHgh2bFPsuN+NYTtGGTqJVuJZa?=
 =?us-ascii?Q?el8Kt4PI4WarajhS4meKhjgpX1h0Wjt6iAJtVtiIc9xg33ugDp1tERXzfvUp?=
 =?us-ascii?Q?f0u8E5PavPvS7oZGdn5V8GcgAfW+LB+O+fiL9NLrQKGamx4mQbeC5KNz2MIv?=
 =?us-ascii?Q?2JDAgH2E20s+BXvOfsAkZm1/UQjRvILCRQD5Sxpogb+NHX2uMcyI10/drBga?=
 =?us-ascii?Q?jP5w8qb89k/45lHS+rD53R9s/h8mSurbsADP+zX2yZPSU5S+93FQuihVXfGd?=
 =?us-ascii?Q?NQpGDqpRo/GK1CR+HZfgnCygb2Z2+wqwUBjBGlFE7zD8GpTPrlKUDhcXccj5?=
 =?us-ascii?Q?dRjeFUPD7hvfYToaX9ptlge04/JxYK7kYErE3AFiMiUJXmWg97X61tKHWmxi?=
 =?us-ascii?Q?ugyYF+zceyahnwtohMFbONdpFd1kkDjkp7yCV32EutPsYEaVp+T9sKZcNAH2?=
 =?us-ascii?Q?eM9xLXa2bUWpZSm7I5rOS5E29RPsSPeLvAT61UP9FFSrRtQ8l6G55Quxh5yf?=
 =?us-ascii?Q?jif/Uv0FHViUtjBEs51v9BQPoDDVM5UZPmvO6+/HurXKU7pdceaaRqRai3f3?=
 =?us-ascii?Q?Rs/8BI8opxzipFsy6dQQvc3HhmdXLbW0oFtlY5l9iBvGJd2IpUuQ0sdFdgBL?=
 =?us-ascii?Q?Vj422hDtm8bmpxKAWoN7Ng4hlovq9ktg8O35Znmog8PxmvWbf9Bz+8/O4EAj?=
 =?us-ascii?Q?ZZ4ld74AQN+GTR0+Z6cxpFNDuAiy1xEeZt41J3w/KkiLU8tcqAJS7YT6WeWY?=
 =?us-ascii?Q?oQgO6VwnwvLuc5nYO54neQRkCRZPs5RTOSUKHrHPVY0xUYWCYS3N39QMtE5r?=
 =?us-ascii?Q?gwVA0O48oXQzs9jfDB68Hu3YwkEhVF7TJkbTI3hB9uklOew0wy3cu7H+FsPH?=
 =?us-ascii?Q?CM713P4WB2BWyvOL3/C6goHMGM2uX+4k09mpyqBCdapaGfpQMyCwtWof49Im?=
 =?us-ascii?Q?Xe17SNkmI9kTzNyhoGOzFku5qHETk7mhvX3Ud0/nBzgLbEEejnkORTwNYVlT?=
 =?us-ascii?Q?9VhwcpXvCzNytNUnbQqikUeYbiwCKWi6MJMVrMecDLeOxUA99rg9kFHqzdUx?=
 =?us-ascii?Q?9mW6CT9i7bpmyRteDW8CBwLE5vcnEMsQVpDprPV3CBt5t8Zl2O9WidLMyj8T?=
 =?us-ascii?Q?yMaZkFzKIcOaV+deXAJ0kYtc0jjz2mwFPm3hvrJ76peq3lbXxW/kuGX57h56?=
 =?us-ascii?Q?AKSTQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 6gk9IVlYTpitr4A5G0erJuh1sVoOU2PsfFZVwhMC6xtYPEMK3PVrxgjw6/G/+of1WWPHAkyhVjXajL4cQ+mPlJdrxomFMVagWxB7mQJsoogKJ0p9A4XSWEpXz3vIYaqMYnHMRpkKhMwab8qOHrdC0i4J2zxtFROTifUOA49HPEAFiSjiknQjXYet/CRleR0dVoztrGVyP1G6cWFEi6YQvpjDFQh0do9CciidFMfV0nmIkGYAsIt8MBCcGlLOa/Brvq3NuZKxoqRPhk79R5QkDbqwjX36oIljPtMb9cJZ/00AKTxH6QVihjfrFRA8NzY0/b9ZEues1tD7hn1hQ83g6w==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2499;6:Q7jtqDWbjGKys3aV0MqWOiqs/3cSiYFszw49ms8uuxLgeBwTb2GYt2JsBQgDhdDbiMIJ2W/6SYUZv3ypGgKpMMWZgVyt/5acaZYHW/V7LgNUYaXDZUvCxnK5Cq1n7NQOkB3S15iKqPluClTsxjn/DUoRIzblP0sH7FeXUVc7vkENFLQq8DuG/EESp8N6BkS6bQWmuG4LbfTc4HANCpev+G/l732YjKwfT4uMwl1LQSQAAJLz3+8HHTQAe1LchEs2f/TXgWe6QllQSApN9RuAJ6M5DVzLB3wsZ4m5xZmcGK0NpVnVGLEoOahqkR5LORC01IvoX/Z0k44WJ9p2Afz6OyQqT2Y+42HQUG6kLREapcbC0bnUQSRF/RZByNUe0/3QiyShQbHlJPYYoXFPgTSFoMyd3P+VZ/UjUAoniyj/VFdt5VcrIokdlEv4RCwT7E/NWjZSYEN9igCQxVB0ffb2AA==;5:/t9sc0Yik1CbeRQiZdXkQ0eoCPvnrGu4ereWuzxAb+rY5IYFWjVa3dXzrgopZ4sFqFMNwg9yynX72yxLGjYDfzD/1os7fAEQafni0wvjMYvyIcL0Gs9u8s+xMtDRzmRmqcueW8Lo6o/9HDRUwofGDB4UjcCXUFmC1hEicVUClyw=;24:VeoffgU9z0AIhaQv8CPugN5negerzv351vuRRWlQ5yb9NMQFCnEnsNWdOAg1/VNZJnM9De/o/IcqSBjxiveca+YNu8pUsg9ntO+qudb28Lg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2499;7:Kaw74mdRmffkGOnxwqWlBHNxYg1OrCmddoHw3GH7MnjdfGYap8qnABpc/PEG/44SwhbYZpbxCfgl38r7paRwIAdNL1OUBDZ8b27bXXahvh/KG9IfVXZo0f/uPV3naBKsmi3rXcyoe/fWA8I62JMyyMCpDqib//pO13WFzy10el+9PrOCo1j8hQAutWzLoeVPh5OiGumOiVa4eKAb9ZHC9u5k3qdDJCRZ9vuK48UQVw9Agx5inYj/S0auFyfYSTPB;20:tKcYSOQZHh2kijGY+JRN/vTRKWRbG3CFNfMmx4isAzSwBV5rGlWZRMpeN7cIAeR+BJ1NxznUpWj+a6tiSe1RR0u9dcRMNSLFZt4WcXiqJdnw8eYVYN92ozW3hOGIUrjjySNsACBPSkCWDdCyFImbaEjLP8gjme18Pnj+SmwDozc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 22:49:09.5800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fcc09e-d544-477c-c678-08d5d7000b9e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2499
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:40:19PM +0100, Song Liu wrote:
> 
> 
> > On Jun 20, 2018, at 1:30 PM, Okash Khawaja <osk@fb.com> wrote:
> > 
> > This patch introduces btf__resolve_type() function and exports two
> > existing functions from libbpf. btf__resolve_type follows modifier
> > types like const and typedef until it hits a type which actually takes
> > up memory, and then returns it. This function follows similar pattern
> > to btf__resolve_size but instead of computing size, it just returns
> > the type.
> > 
> > These  functions will be used in the followig patch which parses
> > information inside array of `struct btf_type *`. btf_name_by_offset is
> > used for printing variable names.
> > 
> > Signed-off-by: Okash Khawaja <osk@fb.com>
> > Acked-by: Martin KaFai Lau <kafai@fb.com>
> > 
> > ---
> > tools/lib/bpf/btf.c |   65 ++++++++++++++++++++++++++++++++++++----------------
> > tools/lib/bpf/btf.h |    3 ++
> > 2 files changed, 48 insertions(+), 20 deletions(-)
> > 
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -17,6 +17,11 @@
> > 
> > #define BTF_MAX_NR_TYPES 65535
> > 
> > +#define IS_MODIFIER(k) (((k) == BTF_KIND_TYPEDEF) || \
> > +		((k) == BTF_KIND_VOLATILE) || \
> > +		((k) == BTF_KIND_CONST) || \
> > +		((k) == BTF_KIND_RESTRICT))
> > +
> > static struct btf_type btf_void;
> > 
> > struct btf {
> > @@ -33,14 +38,6 @@ struct btf {
> > 	int fd;
> > };
> > 
> > -static const char *btf_name_by_offset(const struct btf *btf, uint32_t offset)
> > -{
> > -	if (offset < btf->hdr->str_len)
> > -		return &btf->strings[offset];
> > -	else
> > -		return NULL;
> > -}
> > -
> > static int btf_add_type(struct btf *btf, struct btf_type *t)
> > {
> > 	if (btf->types_size - btf->nr_types < 2) {
> > @@ -190,15 +187,6 @@ static int btf_parse_type_sec(struct btf
> > 	return 0;
> > }
> > 
> > -static const struct btf_type *btf_type_by_id(const struct btf *btf,
> > -					     uint32_t type_id)
> > -{
> > -	if (type_id > btf->nr_types)
> > -		return NULL;
> > -
> > -	return btf->types[type_id];
> > -}
> 
> nit: Why do we need to move these two functions to later of the file? 
No real reason. It looked like this file was following a convention of
keeping statics together. I'll put them back in place if no one objects.

> 
> Other than this,
> 
> Acked-by: Song Liu <songliubraving@fb.com>
Thanks

> 
> > -
> > static bool btf_type_is_void(const struct btf_type *t)
> > {
> > 	return t == &btf_void || BTF_INFO_KIND(t->info) == BTF_KIND_FWD;
> > @@ -234,7 +222,7 @@ int64_t btf__resolve_size(const struct b
> > 	int64_t size = -1;
> > 	int i;
> > 
> > -	t = btf_type_by_id(btf, type_id);
> > +	t = btf__type_by_id(btf, type_id);
> > 	for (i = 0; i < MAX_RESOLVE_DEPTH && !btf_type_is_void_or_null(t);
> > 	     i++) {
> > 		size = btf_type_size(t);
> > @@ -259,7 +247,7 @@ int64_t btf__resolve_size(const struct b
> > 			return -EINVAL;
> > 		}
> > 
> > -		t = btf_type_by_id(btf, type_id);
> > +		t = btf__type_by_id(btf, type_id);
> > 	}
> > 
> > 	if (size < 0)
> > @@ -271,6 +259,26 @@ int64_t btf__resolve_size(const struct b
> > 	return nelems * size;
> > }
> > 
> > +int32_t btf__resolve_type(const struct btf *btf, uint32_t type_id)
> > +{
> > +	const struct btf_type *t;
> > +	int depth = 0;
> > +
> > +	t = btf__type_by_id(btf, type_id);
> > +	while (depth < MAX_RESOLVE_DEPTH &&
> > +			!btf_type_is_void_or_null(t) &&
> > +			IS_MODIFIER(BTF_INFO_KIND(t->info))) {
> > +		type_id = t->type;
> > +		t = btf__type_by_id(btf, type_id);
> > +		depth++;
> > +	}
> > +
> > +	if (depth == MAX_RESOLVE_DEPTH || btf_type_is_void_or_null(t))
> > +		return -EINVAL;
> > +
> > +	return type_id;
> > +}
> > +
> > int32_t btf__find_by_name(const struct btf *btf, const char *type_name)
> > {
> > 	uint32_t i;
> > @@ -280,7 +288,7 @@ int32_t btf__find_by_name(const struct b
> > 
> > 	for (i = 1; i <= btf->nr_types; i++) {
> > 		const struct btf_type *t = btf->types[i];
> > -		const char *name = btf_name_by_offset(btf, t->name_off);
> > +		const char *name = btf__name_by_offset(btf, t->name_off);
> > 
> > 		if (name && !strcmp(type_name, name))
> > 			return i;
> > @@ -371,3 +379,20 @@ int btf__fd(const struct btf *btf)
> > {
> > 	return btf->fd;
> > }
> > +
> > +const char *btf__name_by_offset(const struct btf *btf, uint32_t offset)
> > +{
> > +	if (offset < btf->hdr->str_len)
> > +		return &btf->strings[offset];
> > +	else
> > +		return NULL;
> > +}
> > +
> > +const struct btf_type *btf__type_by_id(const struct btf *btf,
> > +					     uint32_t type_id)
> > +{
> > +	if (type_id > btf->nr_types)
> > +		return NULL;
> > +
> > +	return btf->types[type_id];
> > +}
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -17,6 +17,9 @@ void btf__free(struct btf *btf);
> > struct btf *btf__new(uint8_t *data, uint32_t size, btf_print_fn_t err_log);
> > int32_t btf__find_by_name(const struct btf *btf, const char *type_name);
> > int64_t btf__resolve_size(const struct btf *btf, uint32_t type_id);
> > +int32_t btf__resolve_type(const struct btf *btf, uint32_t type_id);
> > int btf__fd(const struct btf *btf);
> > +const char *btf__name_by_offset(const struct btf *btf, uint32_t offset);
> > +const struct btf_type *btf__type_by_id(const struct btf *btf, uint32_t type_id);
> > 
> > #endif
> > 
> 
