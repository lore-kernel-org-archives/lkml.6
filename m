Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932582AbeEWLZ3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:25:29 -0400
Received: from mxf9a3.netcup.net ([46.38.249.163]:60880 "EHLO
        mxf9a3.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932071AbeEWLZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:25:28 -0400
Authentication-Results: mxf9a3;
        spf=pass (sender IP is 91.41.193.50) smtp.mailfrom=alexander@kurtz.be smtp.helo=shepard
Message-ID: <a3ecf04de4fded7c71284a9695b7146d284d1f22.camel@kurtz.be>
Subject: Expected result when racing listen(2) on two sockets bound to the
 same address
From: Alexander Kurtz <alexander@kurtz.be>
To: linux-kernel@vger.kernel.org
Date: Wed, 23 May 2018 13:15:42 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-/sHIrILijOpUIkZJdKf8"
X-Mailer: Evolution 3.28.2-1
Mime-Version: 1.0
X-PPP-Message-ID: <20180523111543.3626.54019@mxf9a3.netcup.net>
X-PPP-Vhost: kurtz.be
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/sHIrILijOpUIkZJdKf8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Please keep me CC'ed; I'm not subscribed to the list]

Hi!

The program shown below (also available at [0]) does the following:

 * Create two sockets
 * Enable SO_REUSEADDR on both
 * Bind both sockets to [::1]:12345
 * Spawn two threads which both call listen(2) on one socket each
 * Check that at least one thread succeeded

Unfortunately, when running this program on Linux 4.16, it is sometimes
possible that neither thread succeeds in calling listen(2):

    $ uname -a
    Linux shepard 4.16.0-1-amd64 #1 SMP Debian 4.16.5-1 (2018-04-29) x86_64=
 GNU/Linux
    $ time make
    cc -Wall -Wextra -pedantic -Werror -O3    listenrace.c  -lpthread -o li=
stenrace
    for i in `seq 10000`; do ./listenrace; done
    listenrace: listenrace.c:58: main: Assertion `result1 =3D=3D 0 || resul=
t2 =3D=3D 0' failed.
    Aborted
    listenrace: listenrace.c:58: main: Assertion `result1 =3D=3D 0 || resul=
t2 =3D=3D 0' failed.
    Aborted
    listenrace: listenrace.c:58: main: Assertion `result1 =3D=3D 0 || resul=
t2 =3D=3D 0' failed.
    Aborted

    real	0m8.201s
    user	0m6.801s
    sys	0m2.141s
    $=20

As can be seen, on 3 runs (out of 10000) calling listen(2) failed in
*both* threads. Is this to be expected (i.e. "don't do this then") or
could this be some race condition in the Linux kernel?

Best regards

Alexander Kurtz

[0] https://github.com/AlexanderKurtz/listenrace

=3D=3D> Makefile <=3D=3D
CFLAGS =3D -Wall -Wextra -pedantic -Werror -O3
LDLIBS =3D -lpthread

all: listenrace
	for i in `seq 10000`; do ./listenrace; done

listenrace: listenrace.c

clean:
	rm 'listenrace'

.PHONY: all clean

=3D=3D> listenrace.c <=3D=3D
#include <assert.h>      // for assert
#include <netdb.h>       // for addrinfo, getaddrinfo
#include <pthread.h>     // for pthread_create, pthread_join, pthread_t
#include <stdint.h>      // for intptr_t
#include <stdio.h>       // for NULL
#include <sys/socket.h>  // for bind, setsockopt, listen, socket, AF_INET6

int my_socket (struct addrinfo* address) {
    // Create socket
    int fd =3D socket (address->ai_family, address->ai_socktype, 0);
    assert (fd >=3D 0);

    // Enable SO_REUSEADDR
    assert (setsockopt (fd, SOL_SOCKET, SO_REUSEADDR, & (int) { 1 }, sizeof=
 (int)) =3D=3D 0);

    // Bind socket
    assert (bind (fd, address->ai_addr, address->ai_addrlen) =3D=3D 0);

    // Return socket
    return fd;
}

void* my_listen (void* data) {
    int fd =3D (intptr_t) data;

    intptr_t result =3D listen (fd, 64);

    return (void*) result;
}

int main () {
    // Create sockaddr struct
    struct addrinfo hints =3D {
        .ai_family   =3D AF_INET6,
        .ai_socktype =3D SOCK_STREAM,
    };
    struct addrinfo* address =3D NULL;
    assert (getaddrinfo ("::1", "12345", &hints, &address) =3D=3D 0);
    assert (address);

    // Create sockets
    int socket1 =3D my_socket (address);
    int socket2 =3D my_socket (address);

    // Create threads
    pthread_t thread1;
    pthread_t thread2;
    assert (pthread_create (&thread1, NULL, my_listen, (void*) (intptr_t) s=
ocket1) =3D=3D 0);
    assert (pthread_create (&thread2, NULL, my_listen, (void*) (intptr_t) s=
ocket2) =3D=3D 0);

    // Wait for the threads
    void* result1 =3D NULL;
    void* result2 =3D NULL;
    assert (pthread_join (thread1, &result1) =3D=3D 0);
    assert (pthread_join (thread2, &result2) =3D=3D 0);

    // Check that at least one thread could successfully call listen
    assert (result1 =3D=3D 0 || result2 =3D=3D 0);

    return 0;
}
--=-/sHIrILijOpUIkZJdKf8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+DNlMSKIDZ1tz4e4KZScQvp1/pEFAlsFTV4ACgkQKZScQvp1
/pEvDQ/9FE+RhzJn1F8JLajR2qitvMb0mgZfBN+Ea5JFUQmSG3OB+W4jSrBDb8Fy
NJI1oM5mkSaLJhZL16boLU90FD9/iMoJZBainj7puI3jSBwLITgQfjTFdawAsnIp
jzHJSTItZ/cpxvfiTp9cjemNLSJmrK+3H4QxuWn3gKyN8H+EkJ0WU+KtrqrI6fn5
MHH8AAb5+9g8QbGfMEPsKUw6eiDJhiSAPeEkzC1HA2Ip0DyWT1N6A4T2+5C/cZ1M
P2xsfT5kNdJSNGs+VY3fH2I0THfrrSGzQ8K4X4PsCEXPrNMpKWo9SVVlrp8q/bE3
C2NVd6iLPpfiR/sZYw1VmbabA8/ZrCHOTIzuf79z64+WfslxeaK66bqFeJjLH2pk
A2dfd53nk+FH9NPS5n/egkKRLO/sZ7JF+Owqr0YRq/b5O8l7DdUH09RJaWJ2ZQ1p
h14t6bnrkE2I4alJ443IaFQhhP9YLY8seYNvS+YFxu6AfvXz6gHeZfgvhB4SAeMO
8m2jsXizbe9Y+vwyIZ+vtqULk1g0lWdIkDKPhN72o/eWuYmiCrZr8C50NqI8GrB3
JOdj8ozv92yufaW2rSuLxH4V2+wEG3KX4LVO0DU8ZMqjvInXq//MWNLp2QQA3NK6
wRwWPYur+ljVXzeZ8W1CkEozP/LLKJ4sRpe0AFGceEqcCc7ek9w=
=RUOn
-----END PGP SIGNATURE-----

--=-/sHIrILijOpUIkZJdKf8--
