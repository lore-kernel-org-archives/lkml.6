Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AIpwx4+o6HASz0WNN3CSJqlPEF/7iqGkEsCLJnk7otVYSjVdB1JJo65u0e/A5KUol7rkiIEUQ48X
ARC-Seal: i=1; a=rsa-sha256; t=1523644373; cv=none;
        d=google.com; s=arc-20160816;
        b=CDp+FFgQvt/wylsL8GEFxTKoJNrAXOiX/it6pFcawtFEzOOtXwrmsX8lfDc5nrZS3S
         md34cgrZbTUCs9CSbB6FFetb4R9px4it4cLkrHRZZYyUGRsuj3kF6gZCg6w5aDtgJLc2
         /HOFyUqHq5Q/2wtqawsY2ioF3Hr/AOGihcP6BsL6Ik8UKefB0vA7i6fNzJ1y7ANKkCvD
         XSn+4nwULJF9zXfkvia9hfNby+krS/Sk0VMCUegXssyg6DCKyobEZklve09WWykCK9as
         y+13bEG/zqO7AoOG+2V7bKiiZgOsQqo4U6FvUMBXkm8GsS2gL4zFKe5PO0E9jSV5cqSo
         cgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=6FECpZzvMl52wY1S2tpj7G5o/MvANsbt7RzY3VaSyO0=;
        b=Eq9ebkXVCZLLpXlTpVvo/YxiIcShy1Xzo+M8XkOyk3OplEYGbyqLVYfT2aCAQPKICe
         vmh1u+ckwp7JCbML8qBpdMXQPUOIgZ6fQUMcOsS0YbQ0G0ZykBDtkwF35/Q43cML/C+t
         S4bE7tXdDpZOYmxzBQDIaV+kS5F5UaO0qg988EvDcD82bY/TnnkZ8dNqawnTJWwxt1Tn
         uPa3P/mnj6Lvwz8wlayc0vd3EjBb9zA+ovnZ9x3ct1JIge+xTBoXSSQCE1ZjYDFDn0Dn
         k2L0PmqBpiKz1IlCdbXYjkl0UhIZ67Of8Q9RsEEToYDrnXF8iedVsnPoxMpU9d1tSjNG
         D35A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 13 Apr 2018 20:32:50 +0200
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andreas Dilger <adilger@dilger.ca>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	linux-kernel@vger.kernel.org, serge@hallyn.com
Subject: Re: [PATCH 2/6] statfs: use << to align with fs header
Message-ID: <20180413183250.GA8277@gmail.com>
References: <20180413161126.31313-1-christian.brauner@ubuntu.com>
 <20180413161126.31313-3-christian.brauner@ubuntu.com>
 <833FF27F-CFAD-4011-A21C-86B3947BB7D5@dilger.ca>
 <de6ba300-fbef-07ae-651e-87e25ffd701d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de6ba300-fbef-07ae-651e-87e25ffd701d@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597648046265390168?=
X-GMAIL-MSGID: =?utf-8?q?1597656922429330393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 10:55:23AM -0700, Randy Dunlap wrote:
> On 04/13/2018 10:35 AM, Andreas Dilger wrote:
> > On Apr 13, 2018, at 10:11 AM, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> >>
> >> Consistenly use << to define ST_* constants. This also aligns them with
> >> their MS_* counterparts in fs.h
> > 
> > IMHO, using (1 << 10) makes the code harder to debug.  If you see a field
> > in a structure like 0x8354, it is non-trivial to map this to the ST_*
> > flags if they are declared in the form (1 << 10) or BIT(10).  If they are
> > declared in the form 0x100 (as they are now) then it is trivial that the
> > ST_APPEND flag is set in 0x8354, and easy to understand the other flags.
> > 
> > So, my preference would be to NOT land this or the previous patch.

All higher values are already initialized with bit-shifts for MS_*
constants starting with (1<<16) as you can see from the patch and in
fs.h:

> +#define MS_VERBOSE     (1<<15) /* War is peace. Verbosity is silence.
> +                                * MS_VERBOSE is deprecated.
> +                                */
> +#define MS_SILENT      (1<<15)
>  #define MS_POSIXACL    (1<<16) /* VFS does not apply the umask */
>  #define MS_UNBINDABLE  (1<<17) /* change to unbindable */
>  #define MS_PRIVATE     (1<<18) /* change to private */

This just makes it uniform which imho has merit on its own.

If using shifts is considered a valid counter argument because for lack
of ease to analyze struct fields then the values for MS_* flags in fs.h
should probably all be hex values.

In any case, I'm not going to bikeshed over this. The two patches can
simply be left out when applying or I can change it all over to hex
values.

Christian
