Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099D0C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F3B208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DnItKZeV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EROPfMqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F3B208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932961AbeFUKc2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:32:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34756 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932303AbeFUKcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:32:25 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5LASScq004537;
        Thu, 21 Jun 2018 03:32:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=xehroAXK4qXoFXL+Jh9pf8a3VqN8JuGb41jyg2y0Yuk=;
 b=DnItKZeVXXaH4fTIrosjscIfEKB2YM47/hCt/H25hrNLZbGKIqTmAGRMil59IDzHfTu6
 czRNCHC1+CeBl8cwW5Z1Ezqum6+Nb2qKPl++n+dK4490r4ayQw0W3mGDulFvL3OVVAkH
 QpeBqvVygScgq+3l86VOveXslEqSCyVQo0s= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jr5gf0sp8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Jun 2018 03:32:01 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 21 Jun 2018 03:31:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xehroAXK4qXoFXL+Jh9pf8a3VqN8JuGb41jyg2y0Yuk=;
 b=EROPfMqm4JVgbtaLirdD/zHjnOGmW3ZGz23jQBd1wtz4rMQWO3GC9ewTREY38jphFaKyY0W+fqm6N5QcRRqE34DQ4UfAj6fZ8STIn2V1ClNQkMes1HdKg15/EXv+ygrLcyQoaPckwLxq4BA9+7BzQVm3dfY9TLpXUOexSGg+tNc=
Received: from w1t1fb (2620:10d:c092:200::1:81dd) by
 BN7PR15MB2499.namprd15.prod.outlook.com (2603:10b6:406:87::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.19; Thu, 21 Jun 2018 10:31:36 +0000
Date:   Thu, 21 Jun 2018 11:31:27 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Song Liu <songliubraving@fb.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180621103126.GB1176@w1t1fb>
References: <20180620203051.223156973@fb.com>
 <20180620203703.101156292@fb.com>
 <CB2174F3-11DA-496B-A3AF-9FA857C37DB1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CB2174F3-11DA-496B-A3AF-9FA857C37DB1@fb.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c092:200::1:81dd]
X-ClientProxiedBy: AM6PR0502CA0007.eurprd05.prod.outlook.com
 (2603:10a6:209:1::20) To BN7PR15MB2499.namprd15.prod.outlook.com
 (2603:10b6:406:87::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccf25e75-8896-42de-2be9-08d5d7622b90
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR15MB2499;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2499;3:0jYwsn0DRb2P51t2AkzNlxunuBOLncFv+Q361m8doiZtj/zRglfCfX5QrHI09tNjjHvqQYWISb6cUoAdFpMmo8IynrrDlOUBioT8fA4Qn3/PR57v/2DAWTjNlBY8sGPc9DFcGh0iR1NA6DAPokhhAu6otmDTkkZ8sfUgO+R2rZr656Bhp84DF7WF5pOhFQL0FzFc5IA0L0dkKtRKZ7mBf01I4kmf0LCOlEhnCzhvBGrQSddFloRUqwX7cQxEAINs;25:a0EnqRip886qdP7iFayZzI2Ecv2YtxkgPTfNvUrZjjAsACFGJ+E79LHiQCW7D/Y0JO3oRzXHTV4yP01SX/z2TJU8vCoJpMzZWm19xJNz58sjBHoEfYKL9rDBOok78tm2yHxtoOkPzL9WEEHBqAYzi1as1kCFFxfHB3WMz6e5kg8JBBYiJIaRc0shm3ZlRsnM5AvXrj6YDDxnNEuyFvVbehgb6oJ70q2LDDCdatbHgWqd36T7pfFdUqVzRN4bhqvlDugDOcyoHTQ1UC82ZoFcPpCcnSQnkvbPlZ4qOdKlDAjYL+O2mp4/r/cPvyt2KUI1Wbhb4TopOMylcgIEF7b0aQ==;31:EwmlqJar4vvcDl99ZaD3VzrwyUpGjHNQehg+N4tWnGg4KE6t4Jv2F5leLNIDKfO3zkNZPMXI2V/Ldzz4lHbpaBeLI0SWjJ/C0tMmQqWQil69t5xnLAjiq5EU11N0oyfyboCzRObQ17e/dnGH08TT5KM7U9RXDIeL8lZVcBNim7r9/WHdd4kbRXd+kHfkIRCiijNun0//W79UdaSBuae4mZlj/xIK9BBvb8kmP/VEOEA=
X-MS-TrafficTypeDiagnostic: BN7PR15MB2499:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2499;20:0btiAUSX7vTTcAlR3i1/yyyvcbJ1D0uIf+7/GCFSrZzt/5ihKre7v4AitPc3JyBuSoljUBuTRL/6SZXgg5LjhWXjEa8QbXDoie7EL+a9bw2/IlWAm6KmZ47+E/tBuRye1f2QdSNoW0CW8pHau2AXacERZ+ZQLchgUV8D6yCn6msO/T6tpwZuEl7tNPIg4rhy1diL9NWNpLtpNkqKP0m6cirDMAXFM5YYshtOVswayRWzSdMcdbuOj0Y/KkpY04I1fWS6AwjU1YalqT66MmkAQYcYtH8Xlh63vfbvcliieFNN3o2HIQ10KsKXeOQADdANXj/SjUK+Ej5yLwZ9KP3RaboUmrB+hun5pzbeoGEtG2lwEEZnr5j4NZ/v20nwkThxf4Lmg1XFzg8oLrzMwe6BQ1U+N023txxhYrwpGTbXPGN0O1I7uCsuFThayhwmlvZni1Z1MNN4E8jSjd7L8TvmDk0RWFJXQ/r91ZyJmx880TOHZqN5PBqchQfdhckfnj2O;4:qrykoJ/TWX+Eq8OvVYru1PJDLjneKuUbMP79TAfozBxFfQpqSkVP/cwHiCHsZ1qEd963mnvoX21N5CUNvaZcks5ObeDYtk0XxWIDTP4s6B49r/PQM6dUBYmyELH/yViSR56yw1riI5ZHQbso813SKKMpXsww3OsU7vABhjGwL7YwD5Z2f1/5wbLMRRyjpLO5/dx03znibDGb8OVP8qQAfGcRKEgOQEQ6ta+51tHjB5GkW2M3fMZ0JeXbhOP4f6KhRhOoUb5yGA+c6KKnxW+xDj2Yp1c0StPnaFC2LuViZCalitF68h8ciKQHCaN1vqn3nIX1gvvfSYp5NLcaExTotvitxoa7+MW/PFlGDsc3RA4=
X-Microsoft-Antispam-PRVS: <BN7PR15MB24994B5242E533DD21BC5547C6760@BN7PR15MB2499.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(81227570615382);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN7PR15MB2499;BCL:0;PCL:0;RULEID:;SRVR:BN7PR15MB2499;
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(396003)(346002)(39380400002)(199004)(189003)(9686003)(33716001)(81166006)(55016002)(81156014)(486006)(54906003)(476003)(58126008)(446003)(53546011)(6496006)(11346002)(52116002)(106356001)(6666003)(76176011)(105586002)(52396003)(50466002)(59450400001)(386003)(316002)(8936002)(97736004)(6636002)(5660300001)(33656002)(33896004)(16586007)(16526019)(305945005)(6246003)(53936002)(1076002)(229853002)(47776003)(7736002)(478600001)(2906002)(4326008)(39060400002)(25786009)(6116002)(6862004)(86362001)(8676002)(46003)(23726003)(68736007)(18370500001)(42262002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR15MB2499;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR15MB2499;23:3qZDQG3zLyNNmZGJBsdkFv70ludA0rmSdgKCDrXRW?=
 =?us-ascii?Q?huLjCdte3HX2LX9RqYPCPCqE+BDQwUlfsa3GvpamaVRLYBBnV+kp1zDD43h+?=
 =?us-ascii?Q?4zarklm96aKLVBR1Vjgj1gd6PQ1rBRWpF+OO5ykRgQvOi60FnuGIzs8OYVsP?=
 =?us-ascii?Q?Z/JnObEcGfr7nXTe4vYf59voN7ldXm9shGTvsZzzhzMYaRKxc0Zv1fZvFy/O?=
 =?us-ascii?Q?xST3OKOeZpNJvlIbN6BHLCgLayTPEcnjNtlA0yj3Q/OYJL+ECQKR1SsVqqV4?=
 =?us-ascii?Q?E6PETMeTSjHXchEtBMeHyXrfmJf7+YRBXZwPaBkJ8X9Ha471m29KeGAvehhs?=
 =?us-ascii?Q?NAF9/O3JJ/+5mcYNrVrESpveCce5lmJW1d3aJaFC7wt4FJCo8PtkLfhwqdPF?=
 =?us-ascii?Q?iXp/8+DhbaBxiE8+inZt1QPz/i2NKOFcTYFx8QbRjjZT86+Y1XypSeN4EOII?=
 =?us-ascii?Q?4sN1ZfVERuYTvg3CkQ4FSr5HHqKGLg+q+FNMADhzsHTqcYnhCby/qCMDgImf?=
 =?us-ascii?Q?xvhneI8xlCc5JtALNGhnyclymFD0K8g0D3Eu7HM1Wt/Chb9/Ib7/2Lwdiyiv?=
 =?us-ascii?Q?zSX5paYUt8A8NStAZXR7QR3qKR/9gdtwO6NHQM273Mu/EPVnQ5O9Z7XAB/E7?=
 =?us-ascii?Q?/TmHfF1yyojElX1+OCnik+TnlF6UwhKrQiSUnlf27q1lR7yWtt+UfhQLQjA8?=
 =?us-ascii?Q?GaHD//Vv+oKMeYx36wPkSvjF4F68kJGLYTNR1T1+IXtKMw4L37xqi8SMz4dp?=
 =?us-ascii?Q?PnBpGhyxqRTMJpYKcD0t7mp5mbFnhdWt89ztxLBoMT3EARtRmzRWqCafn19+?=
 =?us-ascii?Q?JNRHjM4iBzwIJUMJJMdfrHQcQ7OcT9W/AEhMtgTqBefbljmOgS7qpUkelLPf?=
 =?us-ascii?Q?pZ2BsXF2HpgTqW4AvYciLkJL/+joDLTskVLtHSAzXoA5jPCCswF2xoETpoWd?=
 =?us-ascii?Q?FegPaW6wu1RFc4jRshSMsyl+/yZ21YkgtVig1110C9eBspuB0WruHpLOBWPv?=
 =?us-ascii?Q?XsnbAr3OWAa2o5FAj/+hT/7aiIHGBx7FpYXWbEEM+QN6i39hzuX9uIrcCc/U?=
 =?us-ascii?Q?7zKG9J5XjiXWRPG5v3DbTJR8SGTciSHWXsipWpSeTS7bg19EiH4zn9d6U7/d?=
 =?us-ascii?Q?xMO6ZU6KNtG48Hrlx6KSTx5YMc2uKT2V61qYJ+norMtIrHsYN9Noa5D6yJd5?=
 =?us-ascii?Q?0vCxwpn8uMnYt8SecdODjL7e81amAWVqcPqABYn2mdXkS/dvht/xq147bUwY?=
 =?us-ascii?Q?lXi5VEJ29jDBR44mPuZSSLZ+3n/YgMZU78WV+yS2AI8BG89TItfBITap7wNL?=
 =?us-ascii?Q?ONvCK8XGEGQQCoKUBqc45u5XpivYYKcy/pcxXk10AraLhqxnQiKQb01i7xny?=
 =?us-ascii?Q?oid+EnpBVRIp7iCRqd5PvqNJbg=3D?=
X-Microsoft-Antispam-Message-Info: 1aZL8dLkTWJaMLcC2EbfjiA1LRrTJeo/dqBXRXDYY0J1gR7+lVTTfo9JA5KdK3RP/lfIwqPsgn6bABcX4rV+uG1JXctAUi9RAUz/u2fybjBImeUdIDK5rD5LggbVI/pvbrElNv+QIRf49G2M/rRGN+nwN3oA/YOJHCIK9NBijKnloQGpgNcc9cSAAeW0k3V+2Vk7axTbL3zfuYGF9UolSZPVSWuap1wyu2l7b9AtQWWvFwj+PgR85fgwTRzYT7FWjHyMfGYL5nRkbRrOLjvRvq10rdM4pASy9bT5S3nRdZsIpRA/WBhCPY180hdafNpaxTZi2UYQTu2sWaAuG/zGLg==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2499;6:9/bGI2optM4aeAroGO8ixE7+SyXrZw9aBae1H8g+Sdj2CqTuwIa9xsqXGuxtSwSetp7o4+C7FXLLQaRj01nNGc2xSihYutnRkcuBgKzvsoI1rmjQ3I4y6leR7U7BepMNDjXK2Emi2kf3wG33C+9vheFXpPDGl2aMTC47A3jHn4L4gFfUm4zWamzYeVUO9cCCzfjCGuA+clQ3A40glYSDrl0Dbpkx/eidEdubnmN2IvL8/TqtNhraNTdqkHr7aDpEM6KWu7so/SA7H1hi0aAC0LFTYYbFatuLfC6EtPmvBtOBwN+GbiEueDHaItaX8C03Wn5/r6UVSEJIat4V6b7ne3Yx1GsezvvOBEGieWyBuhztRJ7+wfYuEpmub2JMGRoyCZXTxH+MZa4fBfFNFgk0F0VN2rsj8BLdLE5yi77eiTUVmMp9iFf5/VS6t8CKMdGawe565Yu+JBrJw6qDL5ZuNA==;5:nsktMf3ABFD8NvCTqNHO0h7gnu5MCET4YwRe8qyISwnW2qyYYE6gbSjW1YXtP1Q/JwxRnePZhLYL3ysjBo/TClVczlFpbY7H3kIK3cKYGCuY9ZKaZMi+b9abk/37nShCeqNl/EOsYyIhPwGMtWUQmOZFU0WKdP941nbA68HWqRc=;24:6KHDy3wh5zEcYsOwcAUdvnjPZWnbmGy7xrQoPUTjo+3jIyU29Diu8qru/rrxvvhbOA/wXYLxekwM5KkGFcQ7b6BGCXUGBHR7MOIOyymoiS4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2499;7:TqUeNmEhyDGrsvcFXMnPNxdXmeg1N1Tz8JoppAR2bb3RAkYZJyRlXnfWmF5D0bZzNj0t+ghZlLzaMQF7V7g8/20jJpGcEvY4G+gOqANFe8mW6eG8k4FfQeq243lDeRF8UZA/HooFSY9XBj2WiiKIWQSMrQm3b90XvB0292gMW0HgFidziLvUdVdT/Io7kzjNpvSQOs/VMwPtA9w6mNKAtVBHTGCpQtkWsamZWZVSkxdPfut9vtkRH0JC3be6CAw2;20:q4V1p3TtESCpU0KP1zCFZsx9DeDEgLJbnqBOYdq2vVPtfq5w1K/5aPEAnyJzvLUvR9JPdANTjlxCihM/8zRcUgfkeaeOWyIhD720HR1Urcst5QM+7CVSAYkgH+TIpJ7g6iSylgVaP1eNOs+kj2rl5F8qCHkxHGPXUNL18kujheg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 10:31:36.6679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf25e75-8896-42de-2be9-08d5d7622b90
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2499
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-21_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 12:14:33AM +0100, Song Liu wrote:
> 
> 
> > On Jun 20, 2018, at 1:30 PM, Okash Khawaja <osk@fb.com> wrote:
> > 
> > This consumes functionality exported in the previous patch. It does the
> > main job of printing with BTF data. This is used in the following patch
> > to provide a more readable output of a map's dump. It relies on
> > json_writer to do json printing. Below is sample output where map keys
> > are ints and values are of type struct A:
> > 
> > typedef int int_type;
> > enum E {
> >        E0,
> >        E1,
> > };
> > 
> > struct B {
> >        int x;
> >        int y;
> > };
> > 
> > struct A {
> >        int m;
> >        unsigned long long n;
> >        char o;
> >        int p[8];
> >        int q[4][8];
> >        enum E r;
> >        void *s;
> >        struct B t;
> >        const int u;
> >        int_type v;
> >        unsigned int w1: 3;
> >        unsigned int w2: 3;
> > };
> > 
> > $ sudo bpftool map dump -p id 14
> > [{
> >        "key": 0
> >    },{
> >        "value": {
> >            "m": 1,
> >            "n": 2,
> >            "o": "c",
> >            "p": [15,16,17,18,15,16,17,18
> >            ],
> >            "q": [[25,26,27,28,25,26,27,28
> >                ],[35,36,37,38,35,36,37,38
> >                ],[45,46,47,48,45,46,47,48
> >                ],[55,56,57,58,55,56,57,58
> >                ]
> >            ],
> >            "r": 1,
> >            "s": 0x7ffff6f70568,
> >            "t": {
> >                "x": 5,
> >                "y": 10
> >            },
> >            "u": 100,
> >            "v": 20,
> >            "w1": 0x7,
> >            "w2": 0x3
> >        }
> >    }
> > ]
> > 
> > This patch uses json's {} and [] to imply struct/union and array. More
> > explicit information can be added later. For example, a command line
> > option can be introduced to print whether a key or value is struct
> > or union, name of a struct etc. This will however come at the expense
> > of duplicating info when, for example, printing an array of structs.
> > enums are printed as ints without their names.
> > 
> > Signed-off-by: Okash Khawaja <osk@fb.com>
> > Acked-by: Martin KaFai Lau <kafai@fb.com>
> > 
> > ---
> > tools/bpf/bpftool/btf_dumper.c |  247 +++++++++++++++++++++++++++++++++++++++++
> > tools/bpf/bpftool/btf_dumper.h |   18 ++
> > 2 files changed, 265 insertions(+)
> > 
> > --- /dev/null
> > +++ b/tools/bpf/bpftool/btf_dumper.c
> > @@ -0,0 +1,247 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) 2018 Facebook */
> > +
> > +#include <linux/btf.h>
> > +#include <linux/err.h>
> > +#include <stdio.h> /* for (FILE *) used by json_writer */
> > +#include <linux/bitops.h>
> > +#include <string.h>
> > +#include <ctype.h>
> > +
> > +#include "btf.h"
> > +#include "json_writer.h"
> > +
> > +#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
> > +#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
> > +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> > +#define BITS_ROUNDUP_BYTES(bits) \
> > +	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
> > +
> > +static int btf_dumper_do_type(const struct btf *btf, uint32_t type_id,
> > +		uint8_t bit_offset, const void *data, json_writer_t *jw);
> > +
> > +static void btf_dumper_ptr(const void *data, json_writer_t *jw)
> > +{
> > +	jsonw_printf(jw, "%p", *((uintptr_t *)data));
> > +}
> > +
> > +static int btf_dumper_modifier(const struct btf *btf, uint32_t type_id,
> > +		const void *data, json_writer_t *jw)
> > +{
> > +	int32_t actual_type_id = btf__resolve_type(btf, type_id);
> > +	int ret;
> > +
> > +	if (actual_type_id < 0)
> > +		return actual_type_id;
> > +
> > +	ret = btf_dumper_do_type(btf, actual_type_id, 0, data, jw);
> > +
> > +	return ret;
> > +}
> > +
> > +static void btf_dumper_enum(const void *data, json_writer_t *jw)
> > +{
> > +	jsonw_printf(jw, "%d", *((int32_t *)data));
> > +}
> > +
> > +static int btf_dumper_array(const struct btf *btf, uint32_t type_id,
> > +		const void *data, json_writer_t *jw)
> > +{
> > +	const struct btf_type *t = btf__type_by_id(btf, type_id);
> > +	struct btf_array *arr = (struct btf_array *)(t + 1);
> > +	int64_t elem_size;
> > +	uint32_t i;
> > +	int ret;
> > +
> > +	elem_size = btf__resolve_size(btf, arr->type);
> > +	if (elem_size < 0)
> > +		return elem_size;
> > +
> > +	jsonw_start_array(jw);
> > +	for (i = 0; i < arr->nelems; i++) {
> > +		ret = btf_dumper_do_type(btf, arr->type, 0,
> > +				data + (i * elem_size), jw);
> > +		if (ret)
> > +			return ret;
> 
> Shall we call jsonw_end_array() before return here? 
Thanks. I'll update the patch.

> 
> > +	}
> > +
> > +	jsonw_end_array(jw);
> > +
> > +	return 0;
> > +}
> > +
> > +static void btf_dumper_int_bits(uint32_t int_type, uint8_t bit_offset,
> > +		const void *data, json_writer_t *jw)
> > +{
> > +	uint16_t total_bits_offset;
> > +	uint32_t bits = BTF_INT_BITS(int_type);
> > +	uint16_t bytes_to_copy;
> > +	uint16_t bits_to_copy;
> > +	uint8_t upper_bits;
> > +	union {
> > +		uint64_t u64_num;
> > +		uint8_t u8_nums[8];
> > +	} print_num;
> > +
> > +	total_bits_offset = bit_offset + BTF_INT_OFFSET(int_type);
> > +	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
> > +	bit_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
> > +	bits_to_copy = bits + bit_offset;
> > +	bytes_to_copy = BITS_ROUNDUP_BYTES(bits_to_copy);
> > +
> > +	print_num.u64_num = 0;
> > +	memcpy(&print_num.u64_num, data, bytes_to_copy);
> > +
> > +	upper_bits = BITS_PER_BYTE_MASKED(bits_to_copy);
> > +	if (upper_bits) {
> > +		uint8_t mask = (1 << upper_bits) - 1;
> > +
> > +		print_num.u8_nums[bytes_to_copy - 1] &= mask;
> > +	}
> > +
> > +	print_num.u64_num >>= bit_offset;
> > +
> > +	jsonw_printf(jw, "0x%llx", print_num.u64_num);
> > +}
> > +
> > +static int btf_dumper_int(const struct btf_type *t, uint8_t bit_offset,
> > +		const void *data, json_writer_t *jw)
> > +{
> > +	uint32_t *int_type = (uint32_t *)(t + 1);
> > +	uint32_t bits = BTF_INT_BITS(*int_type);
> > +	int ret = 0;
> > +
> > +	/* if this is bit field */
> > +	if (bit_offset || BTF_INT_OFFSET(*int_type) ||
> > +			BITS_PER_BYTE_MASKED(bits)) {
> > +		btf_dumper_int_bits(*int_type, bit_offset, data, jw);
> > +		return ret;
> > +	}
> > +
> > +	switch (BTF_INT_ENCODING(*int_type)) {
> > +	case 0:
> > +		if (BTF_INT_BITS(*int_type) == 64)
> > +			jsonw_printf(jw, "%lu", *((uint64_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 32)
> > +			jsonw_printf(jw, "%u", *((uint32_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 16)
> > +			jsonw_printf(jw, "%hu", *((uint16_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 8)
> > +			jsonw_printf(jw, "%hhu", *((uint8_t *)data));
> > +		else
> > +			btf_dumper_int_bits(*int_type, bit_offset, data, jw);
> > +		break;
> > +	case BTF_INT_SIGNED:
> > +		if (BTF_INT_BITS(*int_type) == 64)
> > +			jsonw_printf(jw, "%ld", *((int64_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 32)
> > +			jsonw_printf(jw, "%d", *((int32_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) ==  16)
> > +			jsonw_printf(jw, "%hd", *((int16_t *)data));
> > +		else if (BTF_INT_BITS(*int_type) ==  8)
> > +			jsonw_printf(jw, "%hhd", *((int8_t *)data));
> > +		else
> > +			btf_dumper_int_bits(*int_type, bit_offset, data, jw);
> > +		break;
> > +	case BTF_INT_CHAR:
> > +		if (*((char *)data) == '\0')
> > +			jsonw_null(jw);
> > +		else if (isprint(*((char *)data)))
> > +			jsonw_printf(jw, "\"%c\"", *((char *)data));
> > +		else
> > +			jsonw_printf(jw, "%hhx", *((char *)data));
> > +		break;
> > +	case BTF_INT_BOOL:
> > +		jsonw_bool(jw, *((int *)data));
> > +		break;
> > +	default:
> > +		/* shouldn't happen */
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int btf_dumper_struct(const struct btf *btf, uint32_t type_id,
> > +		const void *data, json_writer_t *jw)
> > +{
> > +	const struct btf_type *t = btf__type_by_id(btf, type_id);
> > +	struct btf_member *m;
> > +	int ret = 0;
> > +	int i, vlen;
> > +
> > +	if (t == NULL)
> > +		return -EINVAL;
> > +
> > +	vlen = BTF_INFO_VLEN(t->info);
> > +	jsonw_start_object(jw);
> > +	m = (struct btf_member *)(t + 1);
> > +
> > +	for (i = 0; i < vlen; i++) {
> > +		jsonw_name(jw, btf__name_by_offset(btf, m[i].name_off));
> > +		ret = btf_dumper_do_type(btf, m[i].type,
> > +				BITS_PER_BYTE_MASKED(m[i].offset),
> > +				data + BITS_ROUNDDOWN_BYTES(m[i].offset), jw);
> > +		if (ret)
> > +			return ret;
> 
> Shall we call jsonw_end_object() before return here? 
> 
> > +	}
> > +
> > +	jsonw_end_object(jw);
> > +
> > +	return 0;
> > +}
> > +
> > +static int btf_dumper_do_type(const struct btf *btf, uint32_t type_id,
> > +		uint8_t bit_offset, const void *data, json_writer_t *jw)
> > +{
> > +	const struct btf_type *t = btf__type_by_id(btf, type_id);
> > +	int ret = 0;
> > +
> > +	switch (BTF_INFO_KIND(t->info)) {
> > +	case BTF_KIND_INT:
> > +		ret = btf_dumper_int(t, bit_offset, data, jw);
> > +		break;
> > +	case BTF_KIND_STRUCT:
> > +	case BTF_KIND_UNION:
> > +		ret = btf_dumper_struct(btf, type_id, data, jw);
> > +		break;
> > +	case BTF_KIND_ARRAY:
> > +		ret = btf_dumper_array(btf, type_id, data, jw);
> > +		break;
> > +	case BTF_KIND_ENUM:
> > +		btf_dumper_enum(data, jw);
> > +		break;
> > +	case BTF_KIND_PTR:
> > +		btf_dumper_ptr(data, jw);
> > +		break;
> > +	case BTF_KIND_UNKN:
> > +		jsonw_printf(jw, "(unknown)");
> > +		break;
> > +	case BTF_KIND_FWD:
> > +		/* map key or value can't be forward */
> > +		ret = -EINVAL;
> > +		break;
> > +	case BTF_KIND_TYPEDEF:
> > +	case BTF_KIND_VOLATILE:
> > +	case BTF_KIND_CONST:
> > +	case BTF_KIND_RESTRICT:
> > +		ret = btf_dumper_modifier(btf, type_id, data, jw);
> > +		break;
> > +	default:
> > +		jsonw_printf(jw, "(unsupported-kind");
> 
> "(unsupported-kind)"   (missing ')'). 
Thank you, will update the patch.

> 
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +int32_t btf_dumper_type(const struct btf *btf, json_writer_t *jw,
> > +		uint32_t type_id, const void *data)
> > +{
> > +	if (!jw)
> > +		return -EINVAL;
> > +
> > +	return btf_dumper_do_type(btf, type_id, 0, data, jw);
> nit: btf_dumper_do_type() returns int, while btf_dumper_type() returns int32_t. 
>      This should not matter though. 
Probably an oversight from me. I'll make them consistent. Thank you.

> 
> > +}
> > --- /dev/null
> > +++ b/tools/bpf/bpftool/btf_dumper.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) 2018 Facebook */
> > +
> > +#ifndef BTF_DUMPER_H
> > +#define BTF_DUMPER_H
> > +
> > +/* btf_dumper_type - json print data along with type information
> > + * @btf: btf instance initialised via btf__new()
> > + * @jw: json writer used for printing
> > + * @type_id: index in btf->types array. this points to the type to be dumped
> > + * @data: pointer the actual data, i.e. the values to be printed
> > + *
> > + * Returns zero on success and negative error code otherwise
> > + */
> > +int32_t btf_dumper_type(const struct btf *btf, json_writer_t *jw,
> > +		uint32_t type_id, void *data);
> > +
> > +#endif
> > 
> 
