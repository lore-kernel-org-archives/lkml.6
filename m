Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeCETHr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:07:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751462AbeCETHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:07:45 -0500
Subject: Re: [PATCH 2/3] tpm: reduce poll sleep time between send() and
 recv() in tpm_transmit()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com
Date: Mon, 05 Mar 2018 14:07:32 -0500
In-Reply-To: <20180305180144.GE5791@linux.intel.com>
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
         <20180228191828.20056-2-nayna@linux.vnet.ibm.com>
         <20180301092222.GC29420@linux.intel.com>
         <6ef601be-5627-6746-bd4a-4f391aba8b04@linux.vnet.ibm.com>
         <20180305105633.GE25377@linux.intel.com>
         <20180305180144.GE5791@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030519-0020-0000-0000-000003FEFB05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030519-0021-0000-0000-0000429335C4
Message-Id: <1520276852.10396.351.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803050219
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-05 at 20:01 +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 05, 2018 at 12:56:33PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Mar 02, 2018 at 12:26:35AM +0530, Nayna Jain wrote:
> > > 
> > > 
> > > On 03/01/2018 02:52 PM, Jarkko Sakkinen wrote:
> > > > On Wed, Feb 28, 2018 at 02:18:27PM -0500, Nayna Jain wrote:
> > > > > In tpm_transmit, after send(), the code checks for status in a loop
> > > > Maybe cutting hairs now but please just use the actual function name
> > > > instead of send(). Just makes the commit log more useful asset.
> > > Sure, will do.
> > > > 
> > > > > -		tpm_msleep(TPM_TIMEOUT);
> > > > > +		tpm_msleep(TPM_TIMEOUT_POLL);
> > > > What about just calling schedule()?
> > > I'm not sure what you mean by "schedule()".  Are you suggesting instead of
> > > using usleep_range(),  using something with an even finer grain construct?
> > > 
> > > Thanks & Regards,
> > >      - Nayna
> > 
> > kernel/sched/core.c
> 
> The question I'm trying ask to is: is it better to sleep such a short
> time or just ask scheduler to schedule something else after each
> iteration?

I still don't understand why scheduling some work would be an
improvement.  We still need to loop, testing for the TPM command to
complete.

According to the schedule_hrtimeout_range() function comment,
schedule_hrtimeout_range() is both power and performance friendly.
 What we didn't realize is that the hrtimer *uses* the maximum range
to calculate the sleep time, but *may* return earlier based on the
minimum time.

This patch minimizes the tpm_msleep().  The subsequent patch in this
patch set shows that 1 msec isn't fine enough granularity.  I still
think calling usleep_range() is the right solution, but it needs to be
at a finer granularity than tpm_msleep() provides.

Mimi
