Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeFAWkS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 18:40:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751048AbeFAWkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 18:40:16 -0400
Subject: Re: [PATCH v4 5/8] ima: based on policy require signed firmware
 (sysfs fallback)
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <mjg59@google.com>
Date: Fri, 01 Jun 2018 18:39:55 -0400
In-Reply-To: <20180601182107.GO4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
         <20180601182107.GO4511@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18060122-0008-0000-0000-00000242E2D9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060122-0009-0000-0000-000021A89770
Message-Id: <1527892795.13403.26.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-01_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806010257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-01 at 20:21 +0200, Luis R. Rodriguez wrote:
> On Tue, May 29, 2018 at 02:01:57PM -0400, Mimi Zohar wrote:
> > Luis, is the security_kernel_post_read_file LSM hook in
> > firmware_loading_store() still needed after this patch?  Should it be
> > calling security_kernel_load_data() instead?
> 
> That's up to Kees to decide as he added that hook, and knows
> what LSMs may be doing with it. From my perspective it is confusing
> to have that hook there so I think it could be removed now.
> 
> Kees?

Commit 6593d92 ("firmware_class: perform new LSM checks") references
two methods of loading firmware -  filesystem-found firmware and
demand-loaded blobs.  I assume this call in firmware_loading_store()
is the demand-loaded blobs.  Does that method still exist?  Is it
still being used?

> 
>   Luis
> 
> > 
> > ---
> > 
> > With an IMA policy requiring signed firmware, this patch prevents
> > the sysfs fallback method of loading firmware.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Luis R. Rodriguez <mcgrof@suse.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Matthew Garrett <mjg59@google.com>
> > ---
> >  security/integrity/ima/ima_main.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index a565d46084c2..4a87f78098c8 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -475,8 +475,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
> >  
> >  	if (!file && read_id == READING_FIRMWARE) {
> >  		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> > -		    (ima_appraise & IMA_APPRAISE_ENFORCE))
> > +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> > +			pr_err("Prevent firmware loading_store.\n");
> >  			return -EACCES;	/* INTEGRITY_UNKNOWN */
> > +		}
> >  		return 0;
> >  	}
> >  
> > @@ -520,6 +522,12 @@ int ima_load_data(enum kernel_load_data_id id)
> >  			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
> >  			return -EACCES;	/* INTEGRITY_UNKNOWN */
> >  		}
> > +		break;
> > +	case LOADING_FIRMWARE:
> > +		if (ima_appraise & IMA_APPRAISE_FIRMWARE) {
> > +			pr_err("Prevent firmware sysfs fallback loading.\n");
> > +			return -EACCES;	/* INTEGRITY_UNKNOWN */
> > +		}
> >  	default:
> >  		break;
> >  	}
> > -- 
> > 2.7.5
> > 
> > 
> 
