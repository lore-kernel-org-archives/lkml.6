Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbeBLUZT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:25:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751021AbeBLUZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:25:18 -0500
Date: Mon, 12 Feb 2018 12:25:10 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
        hbabu@us.ibm.com, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] powerpc/vas: Fix cleanup when VAS is not configured
References: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1518234567-24869-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <87d11awzkp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d11awzkp.fsf@concordia.ellerman.id.au>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.7.1 (2016-10-04)
X-TM-AS-GCONF: 00
x-cbid: 18021220-0016-0000-0000-0000083E6163
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008524; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000252; SDB=6.00988787; UDB=6.00502019; IPR=6.00768142;
 BA=6.00005825; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019516; XFM=3.00000015;
 UTC=2018-02-12 20:25:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021220-0017-0000-0000-00003D704499
Message-Id: <20180212202510.GB28183@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802120259
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman [mpe@ellerman.id.au] wrote:
> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> 
> > When VAS is not configured in the system, make sure to remove
> > the VAS debugfs directory and unregister the platform driver.
> >
> > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ...
> > diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
> > index aebbe95..f83e27d8 100644
> > --- a/arch/powerpc/platforms/powernv/vas.c
> > +++ b/arch/powerpc/platforms/powernv/vas.c
> > @@ -169,8 +169,11 @@ static int __init vas_init(void)
> >  		found++;
> >  	}
> >  
> > -	if (!found)
> > +	if (!found) {
> > +		platform_driver_unregister(&vas_driver);
> > +		vas_cleanup_dbgdir();
> >  		return -ENODEV;
> > +	}
> 
> The better patch would be to move the call to vas_init_dbgdir() down
> here, where we know we have successfully registered the driver.

Well, when VAS is configured, init_vas_instance() expects the top level
"vas" debugfs dir to already be setup.

We could have each init_vas_instance() assume it is the first and
unconditionally call vas_init_dbgdir(). vas_init_dbgdir() could make
sure to initialize only once.

Or, we could make a separate pass countng "ibm,vas" nodes. If there are
none, skip both steps (dbgdir and registering platform driver).

Sukadev
