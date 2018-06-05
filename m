Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932081AbeFEWru (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:47:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752318AbeFEWrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:47:48 -0400
Subject: Re: [PATCH v4a 8/8] module: replace the existing LSM hook in
 init_module
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>
In-Reply-To: <CAGXu5j+9P9HLvwC4WfHoxXsz7vYA_raStVDPzA=tNR9f9vr9=Q@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
         <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
         <1527635645.3534.39.camel@linux.vnet.ibm.com>
         <CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
         <1527780226.3427.20.camel@linux.vnet.ibm.com>
         <CAGXu5jLXSEWHorm6=h9+1cP-y8ZX2_ALcra6g9x7Tm-O0kU3DQ@mail.gmail.com>
         <1528234513.3557.16.camel@linux.vnet.ibm.com>
         <CAGXu5j+9P9HLvwC4WfHoxXsz7vYA_raStVDPzA=tNR9f9vr9=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Jun 2018 18:40:11 -0400
Mime-Version: 1.0
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18060522-0028-0000-0000-000002CD8256
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060522-0029-0000-0000-000023848935
Message-Id: <1528238411.3557.32.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=917 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050255
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-05 at 15:26 -0700, Kees Cook wrote:
> On Tue, Jun 5, 2018 at 2:35 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Tue, 2018-06-05 at 12:45 -0700, Kees Cook wrote:
> >
> >> And if you must have a separate enum, please change this to fail
> >> closed instead of open (and mark the fall-through):
> >>
> >> int rc = -EPERM;
> >>
> >> switch (id) {
> >> case LOADING_MODULE:
> >>     rc = loadpin_read_file(NULL, READING_MODULE);
> >>     /* Fall-through */
> >> default:
> >>     break;
> >> }
> >
> > This will fail the sysfs firmware fallback loading and the kexec_load
> > syscall without any message, as you have for init_module.  Is that
> > what you want?
> 
> I'd prefer there be a full mapping of the enums so that everything
> gets passed into loadpin_read_file() :)
> 
> Can the enum be shared or is that nonsensical?

Considering this is v4 of the patch set, it's pretty obvious I did
everything possible not to define a new LSM hook.  Even if we can't
re-use the existing enum, we could define the new enum in terms
of __kernel_read_file_id.

enum kernel_load_data_id {
        __kernel_read_file_id(__data_id_enumify)
};

static const char * const kernel_load_data_str[] = {
        __kernel_read_file_id(__data_id_stringify)
};

Eric, Serge, would using either the existing __kernel_read_file_id
enum or the above definitions be acceptable?

Mimi
