Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EF9FDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BCC20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BChpfaOg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IuY0uV+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BCC20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754440AbeFMEde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 00:33:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48322 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754301AbeFMEdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 00:33:31 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5D4O7kk030246;
        Tue, 12 Jun 2018 21:33:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=/m1CsrkV8KWnir6x6VN67TC0pIBp56iCbF5ffBLbGCc=;
 b=BChpfaOgulSksZaUO4pYiygXoCCRBfkSMLDZCWjeRaHUNNP6Aj9TUOddns89ge0wkZnW
 8bTZndbeQB7UCdhgG3KUCSl5qdurfHfv7O00bUvClz2kj9ZUag78GIS1UlLysKo5WDoE
 4EsEF9pwUab5d0ou04JUve8bFFS7sVK36SM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jju5qg43u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 12 Jun 2018 21:33:23 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 13 Jun 2018 00:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m1CsrkV8KWnir6x6VN67TC0pIBp56iCbF5ffBLbGCc=;
 b=IuY0uV+IJrSi8t3qf8T9MuoJ0ciyk3mC7B4azjI4ILPurHrDHcgvCizvTmYozYDNZ2xY+agzlxIqidY8vLSKkQvozs19Bzvq0Fr2790c1GBawA0XUGsDjFxXMhLZXRYWMQRVVorACKu2XIqGMog05Rzc0TRvEoTr1r3tzefOZLE=
Received: from castle (2620:10d:c090:180::1:db92) by
 DM3PR15MB1082.namprd15.prod.outlook.com (2603:10b6:0:12::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Wed, 13 Jun 2018 04:33:18 +0000
Date:   Tue, 12 Jun 2018 21:33:12 -0700
From:   Roman Gushchin <guro@fb.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: OOPSes in mem_cgroup_protected
Message-ID: <20180613043309.GA5531@castle>
References: <CALAqxLXg8ry5hdNXhJRWE0vHuGbtP4xg=DWQ4t0w_Z-6MHmEmA@mail.gmail.com>
 <CALAqxLXf1QtUYQAE3T0sFzzuKh728KGxpY8pkFnnTLML+idbwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALAqxLXf1QtUYQAE3T0sFzzuKh728KGxpY8pkFnnTLML+idbwg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:180::1:db92]
X-ClientProxiedBy: MWHPR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:300:93::16) To DM3PR15MB1082.namprd15.prod.outlook.com
 (2603:10b6:0:12::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cc59521-b0f5-499c-f493-08d5d0e6ca10
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1082;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;3:9gJGzV/KYVIf2YyGxPLkJwfT7WxSv71XCynqeyRmjrESmap1FiV2xLLMrvdXoRYuvO4EGecRI9QN/jb3NJYqwbjW7Rj79g0yoooszw3LQJngNgfnJOEeqmKRSBiTe6vFPfh3Iu8NNoPee4EkiXqx2fi7SV0CoGN7cuBDE+vt2cJJ8rln7xyGgeIR8WnSH+eVLj71T2FiOUBf5z2orY6fM1Xq2OP09rlDkq/rIuNvdB0ZPmlUgRzJdMfctgbTmz3d;25:PGO18/yEaH7PRcRowxgLxJwXlTOWX+TrNxm8T62Jz/bn3E3Yp3OIL2G3AUiuVuX/qCNdwlxO6iuIFc44p/sW8KDjXd+Ckieh+g4E+G00txgPbbFcE+9nGI7NPyr1DwJZadMJTg5CPhMylB2kEvtJwPf1S2/0KGoodQHOUCy9TCZ32f+KHmcQMwxcUaaYOG8i2rKbSAvr/zABk6gbjYIIogpuaVXjg6H/1vL51psvWAIW/HehRCT/LMZKCoyd+2Mb6VLt7WCtv/tPZjr/hdSovz+Vg6eL5X02UxFwnD7CYS96sh6UTWRE3z3yfq2la3QqbdqOmXN2xUQOMs2TIxD6Bw==;31:0YGziaimHtAiVKgvrKIvaXi4wog7+w58YwrG0UGke5Yz/jmLz9X8dnQzleXBm2wRMMCD9HNL1Y49VBPxZf6b0Z4uF5LZBp5540kabsWWar1YCHa2Gehth1O9GFNfTwUznJDDDR/GkJQz59zn15DKYcCbthxHDWCt2HHo0XfeFyLnHVzonMX1pvSmQz9kxsZxy4Ba+OKIE3/zscbcP/WrmbMoPY7YQQtDDkB0ik9Wq6M=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1082:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;20:Q+AJe4MQSq0vfXk2iU1/uQXI0mMTRrKy+HZ0DkmDX0yfN9ZcgmTarQx2JoGZt/KfMorw6fZGeQDpDHA/oyLfatfZ91Duh5UwGKO6SLrgFzfHxudU1o3J1KLL7n+XhpoEzLUu78rBWkkIpiXFp8gmffZ6jMPDav/jGk8YdHKxBF5H/Dqd9hmgJgVCsnS3JPEev15pUZRkcnCZBFWQSHts7AEhX3O2NTnGtf4mhjdkvACuyOQYMy+Tqdtm5hPcmrC7ppuhYxWxicBQD0O0MTO9feiEUsx+L/bQTuX2wUYeHRbYN+0VBrHNWmvYU3qsa3aOqJJavgFyGzGa1QXHwKkJ7WNfLZWrGaVx9NKYo4XvKzZgz0crduNKnLClypZSAO0MuVECC3ynH4+OqivU0hcJNQrKIwdGosnFMwFNrxuGPkriBpt50oJGT7L5Aunk8vXfitoAc4bBpVqr0Z5kmU2M2CPh9+FOcnAtAOGWP+U+aK3fH2Jtc4eeevr14eP5HGIL;4:9MgeGURpmKE3ff8WX3IN6hX2DxSRSPI+7swtg13LDm4TJfCrt6bc1d6jfMvqB4HnZgTeXvfVkzp40yo+2mhykMXCyo/YAGBMXySN80qaDb125eY/zFDCSsYFlomeHWISR4bEcfEn0YJ5xAyR5eYrJxKFpaMu8YYnX4T/Q8sWghv+eLpfYGAnM6LXmjJzBAjSF6uc2o8/okZFznTwHn/ypfXHLQJJhDKv0AAPrWyFf6MSqXLB9aqfwv9QWh3tQdPmzJk72y8ZRrw6/uUYk1x2fdMriUR1yZykcvEvgvDJ/oiE12fDALJb8h/c6ZSGiYZH5u3LCsVLUGF9u593T8YUeRttLfilA71WFcr7QdScqHjgO9y+sdb5bPTc9yWtmhi0oOkDyDkbt6FKx1QlAHmCFYnHSFnTJJVtBBFmxr34npM=
X-Microsoft-Antispam-PRVS: <DM3PR15MB10828B31A3D7F714FF8E3E38BE7E0@DM3PR15MB1082.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(42068640409301)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1082;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1082;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39380400002)(396003)(39860400002)(189003)(199004)(23726003)(25786009)(9686003)(4326008)(68736007)(6246003)(50466002)(58126008)(966005)(16586007)(316002)(53936002)(2906002)(229853002)(33716001)(47776003)(478600001)(33656002)(54906003)(1076002)(6306002)(106356001)(55016002)(105586002)(76176011)(97736004)(52396003)(6496006)(52116002)(33896004)(6916009)(7736002)(6666003)(81166006)(46003)(8676002)(5660300001)(186003)(86362001)(7116003)(8936002)(16526019)(446003)(386003)(53546011)(305945005)(476003)(81156014)(11346002)(486006)(6116002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1082;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1082;23:P6ZUF4tgf2DY2CX8eQEDuS79cIzoeHtX5QoNGucRV?=
 =?us-ascii?Q?vIEgoeRYRHkMqgca0Dn9WJw7sgnBn6a4m7+TN5tYpAiQ5nypNOc0udp6fNlO?=
 =?us-ascii?Q?EwN264czUgyGD8zhbh9eGU7x8c38KbZu6Owh5d+vLzCF5wA9V+1K1p9KvN7p?=
 =?us-ascii?Q?iUC9s2pWkXXuppTJ54kdG4O4saQnkOz9LP5Y6UjFxEXU+NTqgOsGYgPuznlp?=
 =?us-ascii?Q?8o96mjXtRi7Soji1/wIFN3Qgr2kTnCDwZ6qgCmHILFZkatADE3Vhw+PCYhhJ?=
 =?us-ascii?Q?DQV691mcBqXdDnlMWl1YsQQU9nAWmckXk/h2O83cNgI0mLqmhdTYnYEoIE+u?=
 =?us-ascii?Q?Olch5BzWUZeqVInmHpFWbwFCx3pqCqC1PBjfkWAnimH0V001UkNi+FwYT2+j?=
 =?us-ascii?Q?ExCEp4xd7t6Dt0aitzxqb483+MoicItKe7AMOR/VSjO8IHNO1AbRtKJTVS5K?=
 =?us-ascii?Q?OtVpSe4kQMUmqVlrfwBU0Chw5sTjhv0n8N9ZMeJ/yxQGTStBv5IVVB0hsoLA?=
 =?us-ascii?Q?PbUaXy3Zd+Xx2+ODqXPLx+H+ihUEfY6190wFv200rpiPQFvSPEXT538fVDQO?=
 =?us-ascii?Q?vZsrOLN6UfzQ90RoWnM2mbZZG6zRXNjIqYCCxIO8qjaL5fGlnhlRqWgIzHON?=
 =?us-ascii?Q?DAyditSZfBokETWLnMMy1BVUs/qIFTSboIbTlsGz+dxv7xBmZRkgwsRvQ7n2?=
 =?us-ascii?Q?G6BuxShGQDH55R/BuaSoinN3aPlrg+ayJoQgtOJySF8zEf1Oasc7Fquo4Skg?=
 =?us-ascii?Q?CxE6csduybWObGOthYemqPL63iLf+z8cPpZRCOCPsZUemNhw3vK0NDTBTVH7?=
 =?us-ascii?Q?thi5Fgq40zUPH9uUp8KONq8kcHV3nb+JGdJXa1u6SOlOrcUnjrS5GTbVUm3C?=
 =?us-ascii?Q?MQJJeRppavNBn2QpACgP4tICMEQok26mt011yMA3ie+iCSiGDO4lJT3aHMui?=
 =?us-ascii?Q?BSLtBajiA+VfgzZzVefA59oa6pfj0dqCFvPdBDT9ZYySnVTCMBmOv8BbOuBS?=
 =?us-ascii?Q?X6SuCr3axvYhoK1jBYmudwHSRx+2fdyL9cjpJIYN0H1Dkn0EiV+opscHn9gr?=
 =?us-ascii?Q?CoRTJPhnwPQODmzPkNddyCd/5VFLiMxgsbIa5FnqbzLrcefF55z7bDwmDNeh?=
 =?us-ascii?Q?/sQPEWyvZ8qO5VHdWlKV6uXtv/IilEJY9X/itbLCfI86ik6JoxtrPmhLjc/O?=
 =?us-ascii?Q?rVQ9Qtxi/0eZX2NLSr8LgSV3AAEyC5sqhkMIGS6Tv/0zkBF3nbltuPw+D3kt?=
 =?us-ascii?Q?/1wrVTzwVICIytktLffAA+VAiPZqwBTVtZ46OXqOwXCB4B5vMQBdY1iSAPJI?=
 =?us-ascii?Q?XWaeRCrnemFgt9jPOrglVcgYfVwZsfHTEOsp5MqQoQDZvdtWMAB+X00i9vF7?=
 =?us-ascii?Q?icqFQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: bMy3sH7lHK5ii9g64bzxAkdFMXMa7lJO2j/0xv7oleTjD9wkcEk0v+pyQX5x8XhRjlJUw0sQbYUYtVHmw++Iqgjj+5NArv9V9FZh+Se08selbgBqv+/+cFUVPSiQovkqkJfhIDTn69ySv0ZHaSW4l4CoeqQ4H1RWDk0dVnY+CgU0nPGi0W+W7WQ4u2X7fJ3Z
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;6:4T0pGFn9DjijrNs4/DEn6z7cxJhD0uuw993hcqxTeU6D0IE1vQvPqDRzgSJRZAj/1OvS+awB5g2/ge+E0VMvN2JzfTtZqHT9nGpMto7b1Dl9SfOQatlhU556nzA1/hsDJKb+RjXh8z8cUuQ/cdKXwYxc36g14c2R6/Vrwn/C0uFvNBGY1KJKiv/qonTzhfri7R/gj9Wikit4ZG257hnNKc8EaPRkqDSioqriq5tRu55zx5dS5yHMBJNV45ryi5aK0Uv7CzKxyghbDIBVlF7XuQJM+B0eWWnsf+jjPggXwtVc5rmqaRDntrW9UK0VFIiSTnxwt5EMGu3rBD06oPH01sQNomAggucGftX5q8pkrCMDUD+iwY++mafemItVE/v5BqMBLwDKUnNFwIGoQLxE872UnVt5Uj+R///7KjL2+wfZN3GAuratCGmVwkMkmoefUpHynU2xopmrk/ugTFkkrw==;5:K3U06JUIGRGgaZ14kg0QmDelq79aWfykOLIMFHzBD8QM5FnDKBBz2cwxaOuHQ1/HoVMNeHoHSHz4+29HLB1gU0TqptCF3BsPmt4/Q7QFTLmgdHqvtji/Fsea8r5+2UK9vaenHxZvhwaBO5aaL7FcV7vAYyfWTo8k7ta0sDV5zAQ=;24:19vEi9yNamKItP2Ti6dMYzXfRXfjDuBfElmoyOxtx8vjrayd8t8JobUV5Cr3dUGpLPnD4NrDX3GWWXY8OeG346ZTy0taRruSSs71Kzac+qc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;7:lH5x+Dws9QwK31JVsrV+fjkTXe4TTfPGB1uP1LW2M+QbZPHNoGZeDM4xyn55hPD7lUjrInTCjm985Wue3gNA3o8NHA0L4jafFg8a8OBqdGOk1Ix3uFenmIvUWfk9uN1iWVEZ5Rl6ia2JRu865htQE7eAETr4tLHnP/oamdMEl3Je4B3FJu0LEIb3xBPKdBnYoDI8qUA62Gpa9DyP41mL1DjyOE7jpEr18FYbZ6AD8aeLudgoKQzTCjHADb+VACzk;20:nBBRQK9hUHPclKZ1KM218odXemxfzeL0Sq6UShTojVvxTyVcQtcUtDb0J+cBpcMmOBpMd5z/yYOeQMNkQwjUVNUkHDlonds9qgZDAgZc7LEQFC0J7/I5Bj3TTST3HXkShOnFRmVkIK2/yjDM2JRQWjNJZ8nkL5YqYxL+3QHRCUY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 04:33:18.7892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc59521-b0f5-499c-f493-08d5d0e6ca10
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1082
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 09:08:27PM -0700, John Stultz wrote:
> On Tue, Jun 12, 2018 at 6:02 PM, John Stultz <john.stultz@linaro.org> wrote:
> > Hey Tejun,
> >   With the current linus/master, I'm able to fairly regularly trip
> > OOPSes (two examples below) in mem_cgroup_protected(), which seems to
> > be new.  I haven't managed to trigger this sort of thing with v4.17.
> >
> > I've not had much time to dig in or bisect it - I only know that
> > enabling most of the memory debuging config options didn't seem to
> > trip anything prior to the issue. So I wanted to send you a heads up
> > to see if there was already known, or if there was anything you might
> > suggest to help chase this down.
> 
> 
> So the line where we're crashing seems to be in mem_cgroup_protected():
>   parent_emin = READ_ONCE(parent->memory.emin);
> 
> where I'm guessing the parent->memory value is null, and emin is at
> the 0x120 offset in the strucutre.
> 
> Reverting the following commits seems to avoid the issue.
> bf8d5d52ffe8 ("memcg: introduce memory.min")
> 5f93ad67436b ("mm: treat memory.low value inclusive")
> 230671533d64 ("mm: memory.low hierarchical behavior")
> 
> I'm guessing I'm tripping over some path where the memory value never
> gets initialized?
> 
> Any ideas or suggestions?

Hi, John!

The patch below should fix the problem.
It's in the mm tree right now, and hopefully will be merged upstream asap.
Sorry for the inconvenience.

Thanks!

--

From 276e916d62887b85c35a9d053543bb52b00a81bf Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Wed, 13 Jun 2018 01:01:43 +0000
Subject: [PATCH] mm: fix null pointer dereference in mem_cgroup_protected

Shakeel reported a crash in mem_cgroup_protected(), which can be triggered
by memcg reclaim if the legacy cgroup v1 use_hierarchy=0 mode is used:

[  226.060572] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000120
[  226.068310] PGD 8000001ff55da067 P4D 8000001ff55da067 PUD 1fdc7df067 PMD 0
[  226.075191] Oops: 0000 [#4] SMP PTI
[  226.078637] CPU: 0 PID: 15581 Comm: bash Tainted: G      D
 4.17.0-smp-clean #5
[  226.086635] Hardware name: ...
[  226.094546] RIP: 0010:mem_cgroup_protected+0x54/0x130
[  226.099533] Code: 4c 8b 8e 00 01 00 00 4c 8b 86 08 01 00 00 48 8d
8a 08 ff ff ff 48 85 d2 ba 00 00 00 00 48 0f 44 ca 48 39 c8 0f 84 cf
00 00 00 <48> 8b 81 20 01 00 00 4d 89 ca 4c 39 c8 4c 0f 46 d0 4d 85 d2
74 05
[  226.118194] RSP: 0000:ffffabe64dfafa58 EFLAGS: 00010286
[  226.123358] RAX: ffff9fb6ff03d000 RBX: ffff9fb6f5b1b000 RCX: 0000000000000000
[  226.130406] RDX: 0000000000000000 RSI: ffff9fb6f5b1b000 RDI: ffff9fb6f5b1b000
[  226.137454] RBP: ffffabe64dfafb08 R08: 0000000000000000 R09: 0000000000000000
[  226.144503] R10: 0000000000000000 R11: 000000000000c800 R12: ffffabe64dfafb88
[  226.151551] R13: ffff9fb6f5b1b000 R14: ffffabe64dfafb88 R15: ffff9fb77fffe000
[  226.158602] FS:  00007fed1f8ac700(0000) GS:ffff9fb6ff400000(0000)
knlGS:0000000000000000
[  226.166594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  226.172270] CR2: 0000000000000120 CR3: 0000001fdcf86003 CR4: 00000000001606f0
[  226.179317] Call Trace:
[  226.181732]  ? shrink_node+0x194/0x510
[  226.185435]  do_try_to_free_pages+0xfd/0x390
[  226.189653]  try_to_free_mem_cgroup_pages+0x123/0x210
[  226.194643]  try_charge+0x19e/0x700
[  226.198088]  mem_cgroup_try_charge+0x10b/0x1a0
[  226.202478]  wp_page_copy+0x134/0x5b0
[  226.206094]  do_wp_page+0x90/0x460
[  226.209453]  __handle_mm_fault+0x8e3/0xf30
[  226.213498]  handle_mm_fault+0xfe/0x220
[  226.217285]  __do_page_fault+0x262/0x500
[  226.221158]  do_page_fault+0x28/0xd0
[  226.224689]  ? page_fault+0x8/0x30
[  226.228048]  page_fault+0x1e/0x30
[  226.231323] RIP: 0033:0x485b72

The problem happens because parent_mem_cgroup() returns a NULL pointer,
which is dereferenced later without a check.

As cgroup v1 has no memory guarantee support, let's make
mem_cgroup_protected() immediately return MEMCG_PROT_NONE, if the given
cgroup has no parent (non-hierarchical mode is used).

Link: http://lkml.kernel.org/r/20180611175418.7007-2-guro@fb.com
Fixes: bf8d5d52ffe8 ("memcg: introduce memory.min")
Signed-off-by: Roman Gushchin <guro@fb.com>
Reported-by: Shakeel Butt <shakeelb@google.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/memcontrol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c1e64d60ed02..5a3873e9d657 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5480,6 +5480,10 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	elow = memcg->memory.low;
 
 	parent = parent_mem_cgroup(memcg);
+	/* No parent means a non-hierarchical mode on v1 memcg */
+	if (!parent)
+		return MEMCG_PROT_NONE;
+
 	if (parent == root)
 		goto exit;
 
-- 
2.14.4

