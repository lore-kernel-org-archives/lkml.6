Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EABC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE1720693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IMSGJY5N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FfmNtS7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE1720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030346AbeFSRlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:41:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33002 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1030273AbeFSRlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:41:12 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w5JHdQND003208;
        Tue, 19 Jun 2018 10:40:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=yvZV8MufaMcnkhb+wrsj2vgmLmmJ5wakwvUO7Tz/cBY=;
 b=IMSGJY5Nqf2NPkCqMVsvKLfPGR0tggwZ6mx71+Yv0Dhm6WaHs71ErLkqDpkuYr0kA9eH
 mQ0T3F2Nh9Kss7ei5vrzhqbgsSCuIef5AiwH0XtWrNlcetWOta/qP3qqSh8XhI//xL9z
 kwx09R+yVrWLo18Q81MaFwMUF+vjkwT23yw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2jq2my8rrj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 19 Jun 2018 10:40:56 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 19 Jun 2018 13:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvZV8MufaMcnkhb+wrsj2vgmLmmJ5wakwvUO7Tz/cBY=;
 b=FfmNtS7IYJOimhMQhCmU0QHXx3MOueMAQXMRTAq2JliUDlip//uf1+94GRLAHm7FXn9BqXcGJnW9Zp05xXfRbw5IXNx++qO0gWaMPgDQq5uutQcc5Cj6G0vNglqAzjxkd+yebDhY/rc/hJ/M8WIJwP6SQaI0WrdlwHbAjK58Hjk=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:180::1:fa20) by
 SN2PR15MB1085.namprd15.prod.outlook.com (2603:10b6:804:22::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Tue, 19 Jun 2018 17:40:49 +0000
Date:   Tue, 19 Jun 2018 10:40:44 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 3/3] fs, mm: account buffer_head to kmemcg
Message-ID: <20180619174040.GA4304@castle.DHCP.thefacebook.com>
References: <20180619051327.149716-1-shakeelb@google.com>
 <20180619051327.149716-4-shakeelb@google.com>
 <20180619162741.GC27423@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180619162741.GC27423@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:180::1:fa20]
X-ClientProxiedBy: MWHPR20CA0036.namprd20.prod.outlook.com
 (2603:10b6:300:ed::22) To SN2PR15MB1085.namprd15.prod.outlook.com
 (2603:10b6:804:22::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb40bc96-8033-49ac-4afe-08d5d60bcc65
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN2PR15MB1085;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;3:/lYhaKZwghzgwfefR0lw/MqwEEhv3ru8Jm1fDEcjZ/VtL3d+IMIhY3Mj6YORhxR9B+0z1MahTnWDoUZmOovzJcMQyGcaPp9QbekTrYE/YaFlXYUP6ZCxwN2oL5BT5nOfeu3a0FZyS8YL5FR0fIyjFfK7w+PKChfquYezR8G/ixq0DKc78W/Ukv8x/l6UPWbLIkK0ScaJ63IM6ZtY/NOSGiFsYkqx1Q32F8KzwzCl05o6MrzDkD3nEH3JJ4rMQAQs;25:W1G+zukgq2My/+6uSYTgrDKXZCBdjMvO84CgSQw2lf8ebKFdHyCnVwpRpNxVRAwA7PujKlB2XPUhPj4NAgMMw4g9xi9RPHBWt5iIoTN/RAk96BKO68FLCO7Rux/tbm507wBA44TzsaSvMOwovkVSQA0cvDwfv9Emk009jKShqNaxHW7kMx/yhXvO4UlQxRsxSfVevsPsDUzT1nPhvmj3qL2JhjZ6ntNvR3+Xao6EzyT2jmKrGJzjZqGXKJynlRDPjR2wOV9Xc0fEQ1/Gr99wkzy6bnZwvattJiy9/UfvLuZLqkSgYES7KKEa6uY7r0qMH6BWj44yNpCf10vW5UQKxg==;31:n6uzrhjzxvQUJDKLeM7pe4arKDVx+X4Q16xYDTt9U8Oyt4tiomThlrWAOMaTMyKb2sZhTGJY6w/2EI53t0QNX40JP+Wh5gkD3n0YJg58MM/a2iWov2r/R5kmyqre2ua2dzk7VUF5L3Q0U4fhPMBagpnaCKVbFS8FzKa5OKZq3rfvO9KxHHBOKE2Jkk3I2SwwxZM/E+Djj9wXIFu3t06hklgDl7Y1Oh35yqCVlAQZJZE=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1085:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;20:e66W5O7/EIZaFbfFgyJJGgyPJVGI5eZNjpQw2PUcBCoCKiJprl4U6rE8eSi4E5nQUeaUe6/0bRqt/WOGXadwPHo2OcQhfhQIpLkuU6br96daa+4CceNAT6eKXEchaL5JRTl5RMQJk2Fwun4t9NOazCCeHmZpk2L/s3HGN//Cq1au/ufYzbYQK8pVLFjYtIrK43hs2MhCcb7N26hFROQXLjtiOYr81KMb5rndXA+2lvo4wdJ8kxjwsm30vY2H/R61iLN3zSFlvdQRYwFPNaoMRSIsq6UXfZLGYv4p35jVqeObU4uOXetjDO8exWkyNrxBg1togIpaulMRuvCBQJyOejtkHUVpaeadjN3tYnoQWSLNRNcamQLercyNIQ2jMB6pXUXQ2t7lcfooVWf/4TQOel4n215uCwxai5uaXOLLAGb7bpHHXYBeLvA6cjqi4VxEHIFb0mayjBx8l+C53j32lHFnwIlgrS2k1Pd7Peb5wI33OfiPrsnIK3XvUseLGgrm;4:CcGf097UrnZVDc3n6i602VPHi3k+yrw5VFbKHe46u1rvRwc59XegNA7T3Sz02S+TJq9TXv1VzRnkIkMjAfqQWZNDB9Qni1xDs+g9PXFnhoAUbFjhBVqjJRsmoyBpaNQXSid5UAjw06RhZJ+6GasmRZTElaDuYy9ho8GcO/ZhDbXxF8gsLDvYIX5VnFEjcnL3QPKRZTZereA+M4GsQjNjWaiwz6jV+++WS0dkS8Lv/3trWNr1aJbTkzrYuIeT/Mt+mFtXOzPMSUuv0G8LGjVC4JNskmp47PgrI0ryO2SNibg0Ok1GzNHKFr6uUnq8IElwTeWBuodFnxcabFkARYDAH7QFVuYpzBm/3vJJgT+eKGH0L8SJBahdrkkkMJnVJ6Vk
X-Microsoft-Antispam-PRVS: <SN2PR15MB108569DA8FF60019356139F5BE700@SN2PR15MB1085.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN2PR15MB1085;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1085;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(39860400002)(39380400002)(189003)(199004)(33656002)(186003)(16526019)(76176011)(52116002)(68736007)(16586007)(7696005)(6506007)(52396003)(106356001)(446003)(386003)(54906003)(316002)(9686003)(97736004)(2906002)(1076002)(7416002)(23726003)(486006)(58126008)(11346002)(105586002)(476003)(6246003)(6116002)(5660300001)(59450400001)(478600001)(305945005)(4326008)(229853002)(6666003)(7736002)(39060400002)(86362001)(25786009)(55016002)(8936002)(8676002)(81156014)(6916009)(81166006)(53936002)(50466002)(47776003)(46003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1085;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1085;23:jtZPnFVF9XXCc7Xp9blYrjEmocyHXxA/nZVN+XVlr?=
 =?us-ascii?Q?R6ctjW8nq9eKbnAqVMjyIYqLOQOziw47pQJ0WNe8i3odHZXFu4hdzjgnPZU2?=
 =?us-ascii?Q?mOw8by08KEAbm8n3v9T31Ijsr8YjTUrdTRCeq5mgYwVXltGb9sYAof99V1QA?=
 =?us-ascii?Q?JF61JMFz47YTHBw/t/0muhH7C1rpSilIgWgCRVjMXVA+OC/SdIPQOhXrvmPC?=
 =?us-ascii?Q?+lwseYD1xOxtH3dD/bn4+booVYFPOO7VEUpkGpZBxwlB0iz+sBymmboFCr/7?=
 =?us-ascii?Q?QSg1sYe72FzvTYt+8X0LlTUSUJbu2QYWoJ3evSvesT8yxRmL9CR+B3ZFMfR+?=
 =?us-ascii?Q?F/Q+TxUYLLlcKDw7QW1zqV+rhMuDbyrQ32H34wnp1urT/FBU9Q1nQtSowTjl?=
 =?us-ascii?Q?IdH1fRqKLz3tvhr2/r3JhQF+9xGcTBafjjexLblEfSVUZibDNv8qoFRZhKmx?=
 =?us-ascii?Q?FHYlfPjwSLlL0fiI0asaYEem523FxJqPTsd9JvTLFWoXtHBGpeLY8fWCGLNz?=
 =?us-ascii?Q?tkpIFrdW+/mcgjsu2Vjr8C6ckm+tDI+0ltePA09asPzbuN1yfXg02RkivLLm?=
 =?us-ascii?Q?cvyW9Mh3jQTJs9RgdV/HDWk2/8nSFXbZdorF/qhqLggrDnbuxjzRKUDiVYMj?=
 =?us-ascii?Q?iaOTCECfR+sH6RQRoFPdFDc1ZnrLSo1LQ0aT8zn4rC74FpMtl70U8W57FL5A?=
 =?us-ascii?Q?gYyTPJZwzOnNoSpRhvfNtJDC4+lcHSfre96kR/gQqs7SMCOVm6HPzmkSfID2?=
 =?us-ascii?Q?BU5Ih833TPvJ5obQTOST0SkYpmTdN8ZYG4R8PfcXdsB9UcjzIEwXxEux52Sv?=
 =?us-ascii?Q?L8nwfwQuU+pqTK9mXg0nlWLjM2+WB87P3NrsCgQZvGBMjNBxOMA0drb/+Hq5?=
 =?us-ascii?Q?U1HkNX90NYCYvLohyreTCtbMZbCqQNbLbWgLB0QPheMUMS84ZfHSPsj66V+i?=
 =?us-ascii?Q?uWO3jt5ciIWGaWOS7BgaiPwwI2QMjqxmIMM3tsEo/HmKHzwRRNeB0wnAOQzO?=
 =?us-ascii?Q?6JbGUnjG8uOnPhod5ev8nMXectilbvoTSFIXFovtMGl/jP9XhLOD6xupwP0Z?=
 =?us-ascii?Q?n+1ySnp7omesB6iX+/WJcXIOf3l0YUKBvabyoGcPxPJLwzFsHUNp9RLK90e4?=
 =?us-ascii?Q?QenHm3Yw3PMKhxOwBFtIqX9f32JAPpHFeK3Pp3WPippfYOAx8BiNEdHbm7lz?=
 =?us-ascii?Q?2/aJpDcKelnf4aw4IadW6Wizo/WI549z50MtQNLYYCIkicj28m6kkzFWzm3C?=
 =?us-ascii?Q?TvnKbkeaFiH5032pX//NihfzlvWNpr+wNeWq4gcxieS1T4BQv4oj/F0BRQEX?=
 =?us-ascii?Q?NxFQczTkCRVNMBI/Fw/kLyGp2Bk+gccf6pqd87BQeeD?=
X-Microsoft-Antispam-Message-Info: ZwDW+cJBghHDq29Ugyp7siOxoM3VWPR3nud5/h4A4nVIsBUn3slQE1bRUX4PEBtDE+k1w1F6s8GWKkXhu1sbSboGwI5ygBRnSIZXFP9gmTwZBz1S7nGcvqoFofTHGa5nk1I3BkX8loSvaW2GU+PTnlnG6ikf7VtCfVyungj34QnDlsXs2sVceIzfg/7RBCp0HKLAWzB2Skqm4vEhzSyjjYcDe7X6e+ThLX6bJqvDozj2U8csrvhSZBY8fvuT8DRbAaeXquA/bJD+sa79W8H8saLB1RVERNIdqZwptl7e4qKtRjbNZLQ+teNmOGasm/TZ
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;6:0Nb5wUkfyz+K4zrT9FlTSMC57Ekn4Wp7IbcSUkbuAAlGrzvW8D0ICjGYlbGAdDzXbh2AGS0I9RGUVvKj+2yTsy/E86L3Pmsk6XdSwSCEfvfLQ9JpK9qQLx2D7potxciojVAbsX7yEqfvSC9M949YAv0wF6ilNSLPt/s5ukIICLBfKbTuObvb7y4a7vwnmk/YazdNVIe5NDBoYvmc3R3Ty85Mr9+t2d3wrpPQgXpRF6VuYVyfLqkgD63GObsZMh3GNTn4ITZAMnvNIRQiqG8hMzj9h/tnsmMOtITSx9+ESIFAx+x9g4g9ZNuW17iT5ovOkEe+tHdT1647s8tjJ9GQHt2txJXxV9g3zy32S4nWIn9qksnsmda8BSd6rwCbnyzkZsc4VrsFrzd5WOkIrTzTAEwEUf9IyQu+vHaWo5DgdBzNyNwkxl8yoLE9lzSmZN9Suc1EaeOPWC5rtGlEm5oTjg==;5:5ClWg/GZ0TiVeRPDFPddfRK9kUUWJ9O4PqpUW4lCBfPnrXyOzmBNWsgDHHIMX+W8aTF3YsRVt70HzZz0pODimD1oYkEvhTU7CTnH9ZbwrdAT0eXgTKkK5AqaIlInYlJW3qEKz3v9p38iZZJBG9vjq7v4HZFkQk/wLqdPDbghJ+M=;24:yu9Pb5hrKmQa/Y6QXbxJHhrOlZpzbHm8wQey7qVvMO7Uy5uwwhIRlVJAFrke8kK2DFtXKEPSEuqOL/sA3xQRzD5B4mUozikUKiqeAPIk9Ng=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;7:L38yMIB3GJKEFsGMDcuDfe61JkYm/RTb5/d7gGCSZ3qv9i/GkHXoI3OeqMPKIjs6p99du/gdGkO/jXDDBUKH2XFF45k+XQtWp5T5wiA6FgIgApz1OHL14yV2msLMM3A4spbw6h5alhViWNkSPwWHKO/8GihRmIVlT663eLdbpsbWo5o5HY8mh2q05Lm5taIxNLz5YD1hPQchHg6YGS4DObxRyGa5OooHZiIiR6WxCSKEECBHYJJPwJoX9z2na7s9;20:NWyS3Sr/Qo1QipAPi2AJJrJIIEGUfitEH9PnaQ7FhZFN3Pg6jqxhL1Xiwhc2fHYbs8d9DaZnhP5daakQxpGv4NgUJ3DpJm6qhvPc8CC+ktgxojzLXtkZ5QGVtZYe2fGIZcuXvEvzFXKWXl6tS1omm3Fe5oDc6PCPkFIMmqT29v4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 17:40:49.1236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb40bc96-8033-49ac-4afe-08d5d60bcc65
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1085
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-19_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 12:27:41PM -0400, Johannes Weiner wrote:
> On Mon, Jun 18, 2018 at 10:13:27PM -0700, Shakeel Butt wrote:
> > The buffer_head can consume a significant amount of system memory and
> > is directly related to the amount of page cache. In our production
> > environment we have observed that a lot of machines are spending a
> > significant amount of memory as buffer_head and can not be left as
> > system memory overhead.
> > 
> > Charging buffer_head is not as simple as adding __GFP_ACCOUNT to the
> > allocation. The buffer_heads can be allocated in a memcg different from
> > the memcg of the page for which buffer_heads are being allocated. One
> > concrete example is memory reclaim. The reclaim can trigger I/O of pages
> > of any memcg on the system. So, the right way to charge buffer_head is
> > to extract the memcg from the page for which buffer_heads are being
> > allocated and then use targeted memcg charging API.
> > 
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Greg Thelen <gthelen@google.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  fs/buffer.c                | 14 +++++++++++++-
> >  include/linux/memcontrol.h |  7 +++++++
> >  mm/memcontrol.c            | 21 +++++++++++++++++++++
> >  3 files changed, 41 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 8194e3049fc5..26389b7a3cab 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -815,10 +815,17 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
> >  	struct buffer_head *bh, *head;
> >  	gfp_t gfp = GFP_NOFS;
> >  	long offset;
> > +	struct mem_cgroup *old_memcg;
> > +	struct mem_cgroup *memcg = get_mem_cgroup_from_page(page);
> >  
> >  	if (retry)
> >  		gfp |= __GFP_NOFAIL;
> >  
> > +	if (memcg) {
> > +		gfp |= __GFP_ACCOUNT;
> > +		old_memcg = memalloc_memcg_save(memcg);
> > +	}
> 
> Please move the get_mem_cgroup_from_page() call out of the
> declarations and down to right before the if (memcg) branch.
> 
> >  	head = NULL;
> >  	offset = PAGE_SIZE;
> >  	while ((offset -= size) >= 0) {
> > @@ -835,6 +842,11 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
> >  		/* Link the buffer to its page */
> >  		set_bh_page(bh, page, offset);
> >  	}
> > +out:
> > +	if (memcg) {
> > +		memalloc_memcg_restore(old_memcg);
> > +#ifdef CONFIG_MEMCG
> > +		css_put(&memcg->css);
> > +#endif
> 
> Please add a put_mem_cgroup() ;)

I've added such helper by commit 8a34a8b7fd62 ("mm, oom: cgroup-aware OOM killer").
It's in the mm tree.

Thanks!
