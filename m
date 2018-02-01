Return-Path: <foo00@h08.hostsharing.net>
X-Google-Smtp-Source: AH8x226mJYxAZKSB/isS5v6TbF4RR8GcBjmBGfLu19/yuXOabtK9xAsKNh18yiGf3FypiSZaMTZl
ARC-Seal: i=1; a=rsa-sha256; t=1517464254; cv=none;
        d=google.com; s=arc-20160816;
        b=a3zgZSsCg/UkxKOeWWMCCiQPlPORfoGzL2KpT5kmJ2L2S4koZt5mzv9g7j1QpP95MI
         eWCy4wnbrI5uS8DmTjLUPZPxqwjrg+XONDrHpiO/xRXd2WVLvxcnlIPG+PlSlA0Ozo3J
         ni7YUJDb5+03XDZTAODJ5aOOLIlf7B1IvzzLBexiZbdkNfaCoh8e4HgnSNJmkUy7cibM
         EkQct+WZaiiffAHEvYFjUbkK4jluws76kywaBDlZI0urGpJSTPAMHGMCyMYqoqOWvvY1
         xALu9KAVusv04HNF0NDVB90u5sYJNgmLp0LnaZi0B/dpw+68QtMT6/nShcjsB2lmQ6W9
         mMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=qW2eGPpjh4k//Llxt3/MjkFXAAUybI9eO3VBq/CJY38=;
        b=fnURIa/zlNFgMEw8zAGki3nxcArrcenIEYdrBWkTyUqT3jGlmabH5KOsLbBkkH+xT2
         936F7F1rNjdblbY65G3PU4OMvNr2giaFZHA53jBhOBLlG3gqocXoxz+Lm45se6lotEZa
         l+b9PIKBzT20X3hDwq837WfftTgM3gJWXR4DvlCEP9BTkXp8GknvDMSNLODCs0i7wfDS
         bZrszUoZZrI9alxDnM0zkomQPlacZ3GOt/xqjzfo/cO40KiAvvqbIyJ4knLReye+19TM
         Jb68XEdAXcnwjuBefgzrnlWasHeR/m90rFh0lhmjDkMM8GmmkRw1OSztHhG9ERLfMBQA
         Auhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.95.100 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.95.100 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Date: Thu, 1 Feb 2018 06:50:52 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Stultz <john.stultz@linaro.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Rob Herring <rob.herring@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Ronald Tschalaer <ronald@innovation.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Backport d73e17281665 to v4.15 stable
Message-ID: <20180201055052.GA19082@wunner.de>
References: <CALAqxLVTff-XX7bbQ8a1Pihqe=QW1HDMKST3F3okCV8jY+wGqw@mail.gmail.com>
 <CALAqxLW9gzcBrwy3TWB5x_OpKtcLTe7P8PX4KeUgvibbAaMX_A@mail.gmail.com>
 <20171116213045.GA17506@wunner.de>
 <20171116214504.GB17506@wunner.de>
 <CALAqxLX-qp=rc8P7ynGrUwWHgP2EBAwoEES-aOOuehtnJSDR+A@mail.gmail.com>
 <f181189de5fd4c75da4708425df99e70abc6a127.1510875912.git.lukas@wunner.de>
 <25BE9D66-9609-42D0-8A83-E15758FA3A1B@holtmann.org>
 <CALAqxLXeN3fF_ZUVeKLEYnDy25bd0+D7DgK3eLA3rVv3dEv6qQ@mail.gmail.com>
 <CALAqxLWbh=pmbZEfa03LvOTxBD7bnPVNdHs-os5xZjvhkSWT2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLWbh=pmbZEfa03LvOTxBD7bnPVNdHs-os5xZjvhkSWT2Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591176597588210374?=
X-GMAIL-MSGID: =?utf-8?q?1591176597588210374?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dear Greg,

when you refill the patch queue for v4.15 stable one of these days,
please consider adding

    commit d73e172816652772114827abaa2dbc053eecbbd7
    Author: Lukas Wunner <lukas@wunner.de>
    Date:   Fri Nov 17 00:54:53 2017 +0100
    
    Bluetooth: hci_serdev: Init hci_uart proto_lock to avoid oops

to fix a boot crash on certain machines with UART-attached Bluetooth
which was kindly reported by John Stultz.  The patch unfortunately
lacked a Fixes: or Cc: stable tag.  It landed in Linus' tree 7 hours ago.

Thanks!

Lukas
